# Recyclarr Workspace

Multi-repository workspace for Recyclarr and its supporting resources.

## Repository Boundaries

- Use local file and Git tools to inspect these clones. MUST NOT substitute GitHub or web research
  for local repository exploration.
- Before inspecting a repository, run `git branch --show-current` in it. If the task names or
  implies another branch, stop and notify the user.
- Before a task first reads or edits `wiki/`, confirm the branch matches `wiki/AGENTS.md` branch
  rules, run `git pull --ff-only`, and require empty `git status --short` output. Otherwise stop
  and report the mismatch, pull failure, or unfinished changes. Changes the current task made do
  not block its later wiki steps.
- Follow each repository's own `AGENTS.md` for work in that repository.
- Treat `guides/` as a read-only upstream reference.
- Each `recyclarr.*/` worktree has branch-local instructions. MUST NOT reconcile its `AGENTS.md`
  with another worktree's copy.

## Repository Map

- `recyclarr/` and `recyclarr.*/`: .NET application (main checkout and feature worktrees)
- `wiki/`: Docusaurus documentation site
- `config-templates/`: runtime YAML configuration templates
- `guides/`: upstream TRaSH Guides resources
- `homebrew/`: macOS distribution tap
- `dev-configs/`: private development configuration

When adding or removing a component, update its clone and `<component>.*/` worktree rules in both
root ignore files, plus both `files.exclude` brace lists in `.vscode/settings.json`. `.gitignore`
keeps Git from committing clones as embedded repositories; matching `!` rules in `.ignore`
re-include them for OpenCode file search and path completion; `files.exclude` hides them under
VS Code's root folder, which would otherwise duplicate the workspace folders.

## Public Documentation

- For every Recyclarr task, decide whether `wiki/` must change (user-visible behavior, config, CLI,
  environment, defaults, upgrade steps). Include needed changes in the plan or the work, and
  delegate wiki edits to the `wiki` agent.
- When work changes the wiki, one `acceptance` task started from the Recyclarr worktree covers
  both repositories; its Context names the wiki path and branch. This overrides the
  one-task-per-repository default. Fix code findings directly; send wiki findings back to the
  `wiki` session that made the change.

## Local Runtime Configuration

When running Recyclarr locally, resolve `RECYCLARR_CONFIG_DIR` by running
`mise set RECYCLARR_CONFIG_DIR` from that Recyclarr worktree. MUST NOT guess the path or store
development configuration inside the worktree. Maintainer-only mise values live in the workspace
root `mise.local.toml`, which every worktree inherits.
