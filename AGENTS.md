# Recyclarr Workspace

Multi-repository workspace for Recyclarr and its supporting resources.

## Repository Boundaries

- Use local file and Git tools to inspect these clones. MUST NOT substitute GitHub or web research
  for local repository exploration.
- Before inspecting a repository, run `git branch --show-current` in it. If the task names or
  implies another branch, stop and notify the user.
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

When adding or removing a clone directory, update both root ignore files. `.gitignore` keeps Git
from committing the clone as an embedded repository; a matching `!` rule in `.ignore` re-includes it
for OpenCode file search and path completion.

## Local Runtime Configuration

When running Recyclarr locally, resolve `RECYCLARR_CONFIG_DIR` by running
`mise set RECYCLARR_CONFIG_DIR` from that Recyclarr worktree. MUST NOT guess the path or store
development configuration inside the worktree. Maintainer-only mise values live in the workspace
root `mise.local.toml`, which every worktree inherits.
