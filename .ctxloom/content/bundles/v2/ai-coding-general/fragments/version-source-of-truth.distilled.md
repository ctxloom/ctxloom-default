---
source_sha256: 233894e51923880629bd9823dd58dccaec98c56af39ed0c5b6fcbffcd9ace4a6
---
# Versions: Source of Truth

- Don't put version specs in AI context files. Project config and lockfiles are the source of truth.
- A baked-in version table goes stale once the project moves; the lockfile is always current. Lockfile = contract; table = tombstone.
- AI behavior:
  - On session start, read the lockfile and language-pin files; use the versions declared there.
  - If a feature needs a newer version, propose the bump via the lockfile, not as a one-off in code.
- Verification pattern: "Your suggestion uses [pattern]. Project lockfile pins [package] at [version]. Confirm the pattern is supported at that version, or propose updating the lockfile."
