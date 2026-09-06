---
tags:
  - lefthook
  - hooks
---
# lefthook

This project manages its git hooks with **lefthook**: the hooks
are declared in `lefthook.yml` at the repo root, and
`lefthook install` wires them into `.git/hooks`.

## How to work with it

- Hooks run automatically on the matching git action (pre-commit,
  pre-push, ...). Run a stage manually with
  `lefthook run pre-commit`.
- A failing hook is a FINDING, not an obstacle: read its output
  and fix the cause, then retry the commit. Never bypass with
  `git commit --no-verify` or `LEFTHOOK=0` unless the user
  explicitly tells you to.
- Add or change hooks by editing `lefthook.yml` (each entry is a
  named command with optional glob/exclude), then re-run
  `lefthook install`.
