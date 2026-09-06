---
description: Determine appropriate version bump
tags:
  - versioning
  - semver
content_hash: sha256:cac3b046a464e3c80dc37f22291e139b0ec832df5c0e532d37253b6ac4eaeb41
---
Analyze these changes and recommend the appropriate semantic version bump:

Current version: {{version}}

Changes:
{{changes}}

Consider:
- Are there breaking API changes? → major
- New backward-compatible features? → minor
- Bug fixes only? → patch
- Is this pre-1.0? Different rules apply

Recommend version and explain reasoning.

This prompt only recommends — it does not execute the bump.
When the user wants to actually cut the release, invoke the
`release` prompt, which mandates `versionator release push`
(NOT bare `versionator release`, and NOT a manual sequence of
`versionator bump` + `versionator release` + raw `git push`,
which leaves the local tag/branch and the remote out of sync).