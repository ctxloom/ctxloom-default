---
source_sha256: 2c7e8e65540efc6b4aeef437ccc47b319c03a783d676e0bb909fbb99ce4f5be6
---
# No Provenance in Comments

Comments state invariants; git records the timeline.

## Rule
Keep git-provenance metadata out of code comments and prose about the codebase:
- Commit hashes (`see commit abc123`)
- Milestone tags (`wired in P0.2`)
- PR numbers (`added in #1234`)
- Release versions as historical markers (`introduced in 1.4.0`)
- Author/date stamps (`added by Alice 2024-01-15`)
- TODOs tied to sprints/iterations (`TODO from sprint 47`)

## Why
- Commit hashes break on rebase or squash.
- Milestone tags turn into noise once the project moves past them.
- Author/date stamps become tombstones that outlive the author and the line.
- `git blame` and `git log` already record this; duplicating it guarantees divergence.

## What to write instead
State the load-bearing invariant. If the comment would still hold after a history rewrite, keep it. If not, the timeline entry belongs somewhere else.

Before:
```go
// reflection.Register: wired in P0.2 (commit abc123). Canonical.
```
After:
```go
// reflection.Register: canonical "what does this server speak"
// mechanism. Do not add a parallel descriptor service.
```

## Where provenance lives
- `git blame` / `git log` on the line
- Commit message body and PR description
- `CHANGELOG.md` or release notes
- ADRs
- Issue tracker history

## Exceptions (not provenance)
- Stable external identifiers: RFC numbers, CVE IDs, language-spec versions.
- Public-API `@since` annotations: the version is part of the consumer-facing contract.
- "We tried X and it failed" comments: the rejected approach is invariant content; the dated artifact belongs in the rationale, not the comment.
