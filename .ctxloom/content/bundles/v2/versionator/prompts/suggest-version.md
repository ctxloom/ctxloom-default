---
description: Display current version and suggest next version based on changes
tags:
  - versioning
  - semver
  - analysis
content_hash: sha256:e08d843405a79c373987ae0f60090289cfc891787fa7e2cc749076e3033a0819
---
Analyze the repository and suggest the next semantic version.

Steps:
1. Read the current version from VERSION file
2. Get changes since last tag using `git log --oneline $(git describe --tags --abbrev=0 2>/dev/null || echo "")..HEAD`
3. Analyze the commit messages and code changes

Display format:
```
Current version: X.Y.Z
Commits since last release: N

Changes:
- [list key changes]

Suggested next version: X.Y.Z
Reasoning: [explanation based on semver]
```

Semver rules:
- MAJOR (X): Breaking API changes, incompatible modifications
- MINOR (Y): New backward-compatible features, significant enhancements
- PATCH (Z): Bug fixes, minor improvements, documentation

Pre-1.0 rules:
- Breaking changes can be MINOR (0.X.0)
- Features can be PATCH (0.0.X)

Be conservative: when uncertain, suggest the lower bump level.

This prompt only suggests — it does not execute. When the user
asks to actually cut the release, hand off to the `release`
prompt, which mandates `versionator release push` (NOT bare
`versionator release`, and NOT raw `git push` of the tag).