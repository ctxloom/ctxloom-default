---
tags:
  - review
  - base
---
# Code Review — Thoroughness

Review the ACTUAL code. Do NOT judge from summaries, prior memories,
commit messages, or file names — those mislead. For every file in scope:

- OPEN and read the file (or the full diff hunk plus enough surrounding
  context to understand it), top to bottom. A name like `validate.go`
  or a summary like "adds validation" is a hypothesis, not evidence.
- Do not assume a function does what its name says — read its body.
- Do not skip a file because it "looks unrelated" or "looks generated" —
  confirm by reading. Name anything you deliberately skip, and why.
- Trace the change end to end: callers, callees, error paths, and the
  data it touches — not only the lines that changed.
- Trust what you have read this session over anything recalled from a
  previous one; re-read rather than rely on memory.

If the change is too large to read in full, say so explicitly and scope
exactly what you did and did not read — never imply coverage you did not do.