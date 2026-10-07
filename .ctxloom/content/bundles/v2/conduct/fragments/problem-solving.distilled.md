---
distilled_by: claude-opus-5-5
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

Comment explaining WHY a workaround exists = defect diagnosis already done. Writing it down ≠ reporting it; route around the bug and the comment becomes a tombstone the next reader takes as settled. Cause survives.

**Red flags:** arbitrary limits with justifying comments; retry/sleep/poll around deterministic things; "without this, X breaks"; thresholds tuned down until a gate stopped failing; fallbacks degrading real failures into silence; re-implementing another tool's private behaviour.

## Three Steps to Land a Workaround

1. Escalate before landing: name the bug, locate it. The workaround is locally cheaper than escalating — that asymmetry is why this rule exists.
2. Dispose of the root cause: fix it, or raise it with the human (carrying the diagnosis). Not "file it" — you do not create a task on your own initiative. Unreported = agreed to forget.
3. Comment states invariant, not history. No invariant = scar, not fix.

**Prefer the fix — a test, not an estimate** (nobody calibrates "is it small?" the same way twice): already root-caused (the comment proves it) + code already read + the project's fast gates settle it (build, lint, single-package test; seconds) = do it now, and there is no workaround to land.

**Raise it instead only when the work can't happen now:** needs a HUMAN DECISION (name the fork and options), lives in another repo/release, or is materially larger than the turn. Say WHY IT MATTERS, WHAT NEEDS TO HAPPEN, WHAT WOULD SETTLE IT; cite by SYMBOL, never line numbers, SHAs or file inventories — nothing recomputes those, so they go stale and keep their authority while lying. The human decides whether it becomes a row, written once they accept. Surfacing is what stops a defect being forgotten; filing was only a means to that, and as a reflex it grew the open pile to the size of everything ever completed.

## Tuned-Silent Gates Measure Nothing

Never tune thresholds/timeouts/coverage until a gate stops complaining. A silenced gate is worse than none: it manufactures confidence. If a gate is wrong, fix it deliberately and say so.

## "Works in CI" ≠ "Works"

CI ≠ local is where bugs hide (clean checkouts, no TTY, etc). The difference IS the finding — chase it; don't paper over it.
