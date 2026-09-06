---
tags:
  - golang
  - coding
content_hash: sha256:68c7d75f6dfcc5be95ce05c76e58cbf7a11a596b741db2db6a13c4595063aabd
---
# Go Rules

- Assertions: `testify/assert`. Prefer fakes over mocks.
- No `init()` functions — explicit initialization.
- No package-level variables — dependency injection.
- Logging: `slog` with structured attributes.