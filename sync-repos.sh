#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if [[ -t 1 ]]; then
    c_reset=$'\033[0m'
    c_green=$'\033[32m'
    c_yellow=$'\033[33m'
    c_red=$'\033[31m'
    c_cyan=$'\033[36m'
else
    c_reset='' c_green='' c_yellow='' c_red='' c_cyan=''
fi

pids=()
cleanup() { kill "${pids[@]}" 2>/dev/null; wait; exit 130; }
trap cleanup INT TERM

# sync_repo <dir> <url> [--origin <name>] [--also <branch>...]
sync_repo() {
    local dir=$1 url=$2; shift 2
    local name=()
    local allowed=()

    while (( $# )); do
        case $1 in
            --origin) name=(--origin "$2"); shift 2 ;;
            --also)   shift; while (( $# )) && [[ $1 != --* ]]; do allowed+=("$1"); shift; done ;;
            *)        shift ;;
        esac
    done

    (
        if [[ ! -d "$dir/.git" ]]; then
            if git clone "$url" "$dir" ${name[@]+"${name[@]}"} > /dev/null 2>&1; then
                echo "${c_cyan}[clone]${c_reset} $dir"
            else
                echo "${c_red}[FAIL]${c_reset} $dir: clone failed"
                exit 1
            fi
        else
            local mainline
            mainline=$(git -C "$dir" symbolic-ref refs/remotes/origin/HEAD 2>/dev/null \
                | sed 's|refs/remotes/origin/||')

            if [[ -z "$mainline" ]]; then
                echo "${c_yellow}[skip]${c_reset} $dir: cannot determine mainline branch"
                exit 0
            fi

            allowed+=("$mainline")

            local current
            current=$(git -C "$dir" symbolic-ref --short HEAD 2>/dev/null || echo "")

            local on_allowed=false
            for branch in "${allowed[@]}"; do
                if [[ "$current" == "$branch" ]]; then
                    on_allowed=true
                    break
                fi
            done

            if ! $on_allowed; then
                echo "${c_yellow}[skip]${c_reset} $dir: not on ${allowed[*]} (on ${current:-detached HEAD})"
                exit 0
            fi

            if ! git -C "$dir" diff --quiet || ! git -C "$dir" diff --cached --quiet; then
                echo "${c_yellow}[skip]${c_reset} $dir: has local changes"
                exit 0
            fi

            local before after
            before=$(git -C "$dir" rev-parse HEAD)
            if git -C "$dir" pull --ff-only > /dev/null 2>&1; then
                after=$(git -C "$dir" rev-parse HEAD)
                if [[ "$before" == "$after" ]]; then
                    echo "${c_green}[ok]${c_reset} $dir: up to date"
                else
                    echo "${c_green}[pull]${c_reset} $dir: updated"
                fi
            else
                echo "${c_red}[FAIL]${c_reset} $dir: pull failed (ff-only)"
                exit 1
            fi
        fi
    ) &
    pids+=($!)
}

sync_repo recyclarr         git@github.com:recyclarr/recyclarr.git
sync_repo wiki              git@github.com:recyclarr/wiki.git              --also next
sync_repo config-templates  git@github.com:recyclarr/config-templates.git  --also v8
sync_repo homebrew          git@github.com:recyclarr/homebrew-recyclarr.git
sync_repo dev-configs       git@github.com:rcdailey/recyclarr-dev-configs.git
sync_repo guides            git@github.com:TRaSH-Guides/Guides.git        --origin upstream

failed=0
for pid in "${pids[@]}"; do
    wait "$pid" || ((failed++))
done

if ((failed > 0)); then
    echo "${c_red}Failed: $failed repo(s)${c_reset}"
    exit 1
fi
