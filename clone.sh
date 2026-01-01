#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

pids=()

clone_or_pull() {
    local dir=$1
    local url=$2
    local name=${3:-}

    (
        if [[ -d "$dir/.git" ]]; then
            echo "Updating $dir..."
            git -C "$dir" pull --ff-only
        else
            echo "Cloning $dir..."
            git clone "$url" "$dir" ${name:+--origin "$name"}
        fi
    ) &
    pids+=($!)
}

clone_or_pull recyclarr         git@github.com:recyclarr/recyclarr.git
clone_or_pull wiki              git@github.com:recyclarr/wiki.git
clone_or_pull config-templates  git@github.com:recyclarr/config-templates.git
clone_or_pull homebrew          git@github.com:recyclarr/homebrew-recyclarr.git
clone_or_pull dev-configs       git@github.com:rcdailey/recyclarr-dev-configs.git
clone_or_pull guides            git@github.com:TRaSH-Guides/Guides.git upstream

failed=0
for pid in "${pids[@]}"; do
    wait "$pid" || ((failed++))
done

if ((failed > 0)); then
    echo "Failed: $failed repo(s)"
    exit 1
fi

echo "Done."
