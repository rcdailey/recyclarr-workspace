# Recyclarr Workspace

Multi-repo development workspace for the Recyclarr ecosystem.

## What is Recyclarr?

CLI tool that syncs TRaSH Guides recommendations to Sonarr/Radarr instances.

## Local Repository Clones

All repositories below are **cloned locally** in this workspace directory. ALWAYS use local file
tools (Read, Glob, Grep, Bash) to explore them. NEVER use octocode or other remote GitHub tools for
any repo that exists here. Always verify the checked out branch in each repo before you start
reading work. If the branch is not what you expect, **immediately stop your task** and notify the
user.

- `recyclarr/` - Main .NET CLI application (primary codebase)
- `wiki/` - Docusaurus documentation site (recyclarr.dev)
- `config-templates/` - Official YAML config templates, community-contributed (cloned by recyclarr
  at runtime)
- `homebrew/` - Homebrew tap for macOS distribution
- `dev-configs/` - Personal development configs (private)
- `guides/` - TRaSH-Guides upstream (external org, read-only reference)

## Repo Relationships

- recyclarr fetches config-templates and guides as resource providers at runtime
- wiki documents recyclarr (master = recyclarr.dev, next = next.recyclarr.dev for pre-release)
- homebrew auto-updates on recyclarr releases

## AI Session Guidance

Each repo has its own AGENTS.md with repo-specific directives. Defer to those for:

- Coding standards (`recyclarr/AGENTS.md`)
- Documentation conventions (`wiki/AGENTS.md`)
- Template structure (`config-templates/AGENTS.md`)

This file provides orientation only - not coding standards or detailed workflows.
