---
source_sha256: 4926bd20f364a2003daac1ca4c34b0c571e1f3c8a85000fdaf3d364b4be6796c
---
# Git Practices

## Branching
- No branches or PRs unless asked
- Short descriptive branch names
- All changes for a task go in one branch
- Branch off `main` or `master` only; if asked to branch off anything else, push back and confirm first

## Commit Messages
- Straightforward and to the point; describe code changes only
- No extraneous details or meta-commentary
- **NEVER** mention Claude, Anthropic, AI, or "Generated with"

## Breaking Changes
- **<1.0:** no backwards compatibility required; remove deprecated code immediately
- **New major versions:** no backwards compatibility required; remove deprecated APIs
- **Post-1.0 minor/patch:** discuss breaking changes before implementing

## Pre-commit
- Run linters, formatters, and tests before committing; never commit broken code
- Fix pre-commit errors automatically, without asking

## Bypassing Hooks
- Only for WIP on feature branches
- Document with `--no-verify` and reasoning
