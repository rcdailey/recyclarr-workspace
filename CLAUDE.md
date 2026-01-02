# Recyclarr Workspace

Multi-repo development workspace for the Recyclarr ecosystem.

## What is Recyclarr?

CLI tool that syncs TRaSH Guides recommendations to Sonarr/Radarr instances.

## Local Repository Clones

All repositories below are **cloned locally** in this workspace directory. ALWAYS use local file
tools (Read, Glob, Grep, Bash) to explore them. NEVER use octocode or other remote GitHub tools for
any repo that exists here.

- recyclarr/ - Main .NET CLI application (primary codebase)
- wiki/ - Docusaurus documentation site (recyclarr.dev)
- config-templates/ - Official YAML config templates, community-contributed (cloned by recyclarr at
  runtime)
- homebrew/ - Homebrew tap for macOS distribution
- dev-configs/ - Personal development configs (private)
- guides/ - TRaSH-Guides upstream (external org, read-only reference)

## Repo Relationships

- recyclarr fetches config-templates and guides as resource providers at runtime
- wiki documents recyclarr (master = recyclarr.dev, next = next.recyclarr.dev for pre-release)
- homebrew auto-updates on recyclarr releases

## Cross-Repo Workflows

New feature: recyclarr (implement) -> wiki (document) -> config-templates (add examples)

## Workspace Scripts

- clone.sh - Bootstrap/update all repos

## AI Session Guidance

Each repo has its own CLAUDE.md with repo-specific directives. Defer to those for:

- Coding standards (recyclarr/CLAUDE.md)
- Documentation conventions (wiki/CLAUDE.md)
- Template structure (config-templates/CLAUDE.md)

This file provides orientation only - not coding standards or detailed workflows.
