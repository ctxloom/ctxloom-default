---
description: Tools this bundle's content needs where agents run (applied via `ctxloom tooling`, user-approved)
tags:
  - tooling
---
- reprise: Homebrew or GitHub (https://github.com/ctxloom/reprise)
  — a release binary if published, else build from source
  (`cargo build --release`; Rust 2024 toolchain).
- lefthook: reprise gates commits through it (see the lefthook
  bundle's tooling) — `brew install lefthook` or a release from
  https://github.com/evilmartians/lefthook/releases, then wire
  `reprise check` as a pre-commit command in lefthook.yml.
