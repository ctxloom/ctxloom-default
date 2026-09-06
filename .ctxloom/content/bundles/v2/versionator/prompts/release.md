---
description: Release workflow for versionator projects
tags:
  - versioning
  - release
  - workflow
content_hash: sha256:f4d8b288864a83d740fa89190aa0b1ca9a7dfd3663d61e0a99acacc52294c9c1
---
Release workflow for versionator. User MUST specify version.

User input: $ARGUMENTS
- Fixed version: "0.1.0", "1.0.0", "2.3.4"
- Bump instruction: "patch", "minor", "major"

If no version specified, STOP and ask the user. Do not guess.

Steps:
1. Parse user input for version or bump instruction
2. Stage all changes: `git add -A`
3. Analyze changes and create appropriate conventional commit message
4. If bump instruction (patch/minor/major):
   - Commit with appropriate conventional prefix (fix:/feat:/feat!:)
   - Run `./versionator bump` to increment and amend
5. If fixed version (X.Y.Z):
   - Write version to VERSION file
   - Commit with version in message
6. Run `./versionator release push` to create the tag and release
   branch AND push them to origin in one atomic step.

CRITICAL — ALWAYS use `versionator release push`. Never use
`versionator release` alone, and never substitute raw
`git push origin <tag>` / `git push origin <branch>`.
- `versionator release` only creates the local tag and branch; it
  does NOT publish them. Splitting create-and-push lets the local
  and remote drift (e.g. a tag created locally then never pushed
  becomes an orphan that conflicts with future `release push`
  attempts).
- `release push` is the single source of truth for "this version
  is now public." Downstream automation that fires on a tag-push
  event (GitHub Releases, release-completer workflows, deploy
  pipelines, artifact builds) only fires reliably when the tag
  and the branch land on origin together.
- If you have already created the tag/branch locally with bare
  `release`, run `versionator release push --force` to reconcile,
  then push the underlying commit (`git push origin main`).

IMPORTANT: Never auto-select version. User must explicitly specify.