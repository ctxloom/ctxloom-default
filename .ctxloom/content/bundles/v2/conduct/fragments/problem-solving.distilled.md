---
distilled_by: claude-haiku-4-5-20251001
---
# Workarounds and Problem Solving

**Root cause first.** Fix at source, never workaround without asking.

## When Encountering Failing Functionality

1. Find root cause — investigate actual source.
2. If simple problem needs complex fix, ask before proceeding.
3. Present options: proper fix (effort), workaround (trade-offs), test disable (why), alternatives.
4. Cost/benefit: tech debt, maintainability, time per option.
5. Document decision and reasoning.

## Workaround Comment = Unreported Bug

Comment explaining WHY a workaround exists = defect diagnosis. Comments aren't reports; they become tombstones others read as settled. Cause survives unaddressed.

**Red flags:** arbitrary limits with justifying comments; retry/sleep/poll around deterministic things; "without this, X breaks"; thresholds tuned to silence gates; fallbacks masking real failures.

## Three Steps to Land a Workaround

1. Escalate: name the bug, locate it.
2. Dispose of the root cause: fix it, or raise it with the human (carrying the diagnosis). You do not create a task on your own initiative. Unreported = agreed to forget.
3. Comment states invariant, not history. No invariant = scar, not fix.

**Prefer the fix — a test, not an estimate:** already root-caused (the comment proves it) + code already read + the project's fast gates settle it (build, lint, single-package test) = do it now, and there is no workaround to land.

**Raise it instead only when the work can't happen now:** needs a HUMAN DECISION (name the fork and options), lives in another repo/release, or is materially larger than the turn. Say WHY IT MATTERS, WHAT NEEDS TO HAPPEN, WHAT WOULD SETTLE IT; cite by SYMBOL, never line numbers, SHAs or file inventories. The human decides whether it becomes a row.

## Tuned-Silent Gates Measure Nothing

Never tune thresholds/timeouts/coverage to silence gates. Silenced gates = false confidence. Fix gates deliberately.

## "Works in CI" ≠ "Works"

CI ≠ local hides bugs (clean checkouts, no TTY, etc). Chase environmental differences; don't paper over them.