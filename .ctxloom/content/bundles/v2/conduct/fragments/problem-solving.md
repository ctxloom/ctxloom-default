---
tags:
  - workflow
  - debugging
notes: |-
  Exists because a workaround is always locally cheaper than the
  fix, so without a rule the workarounds win by default and the
  defects they route around survive. The core observation: a
  comment explaining WHY a workaround is needed is already a
  completed defect diagnosis — leaving it in code instead of
  reporting it turns the diagnosis into a tombstone the next reader
  takes as settled. The disposition is deliberately fix-or-raise and
  never file-on-initiative: an agent that files freely turns every
  observation into a row, which is how an open pile grows to the
  size of everything ever completed. Surfacing is what stops a
  defect being forgotten; filing was only ever a means to that, and
  the human decides which findings earn a row. The gate rule defends
  against manufactured confidence: a
  threshold tuned until the gate stops complaining reads as green
  while measuring nothing. Origin: derived from the failure shapes
  the body lists; no specific incident is recorded in it.
content_hash: sha256:df14fb31a8da3019f12f7d88e536cae04818a97195731702a1bcaff30d2a6578
---
# Workarounds and Problem Solving

**Core Principle:** Find the root cause before figuring out a solution. Fix problems at their source.

## When Encountering Failing Functionality

1. **Find the root cause first** — Do not create workarounds without asking. Always investigate and identify the actual source of the problem.
2. **Ask before applying complex fixes to simple problems** — If a simple problem seems to require a complex solution, stop and ask questions first.
3. **Prompt for guidance** with options: fix properly (estimate effort), create workaround (document trade-offs), disable test temporarily (document why), alternative approaches.
4. **Perform cost/benefit analysis:** pros and cons of each option, technical debt implications, impact on maintainability, time investment required.
5. **Document decision:** whatever path is chosen, document the reasoning.

## The tell: a comment justifying a workaround is an unreported bug report

If you find yourself writing a comment that explains WHY a workaround
is necessary, you have already diagnosed a real defect. Writing the
diagnosis down is not the same as reporting it. Route around the bug
and the comment becomes its tombstone: the next person reads it as
settled fact, and the cause survives.

Watch for the shapes this takes: an arbitrary cap or limit with a
justifying comment; a retry, sleep, or poll around something that
should be deterministic; a "without this, X breaks" note; a threshold
tuned downward until a gate stopped failing; a fallback that degrades
a real failure into silence; a re-implementation of another tool's
private behaviour.

## A workaround is not DONE until all three

1. **Escalate before landing it.** Name the real bug and where it
   lives. The workaround is locally cheaper than the escalation —
   that asymmetry is exactly why this rule needs stating.
2. **Dispose of the root cause: fix it, or raise it with the
   human.** Not "file it" — you do not create a task on your own
   initiative. Carry the diagnosis you just wrote in the comment
   either into the fix or into what you put in front of them. An
   unreported root cause is a bug you have agreed to forget.
3. **The comment states the invariant, not the history.** If you
   cannot state an invariant, you do not have a fix — you have a
   scar.

Prefer the fix, and the bar is a test rather than an estimate,
because nobody calibrates "is it small?" the same way twice: you
have ALREADY root-caused it — writing that comment is the proof —
the fix touches code you have ALREADY read, and the project's fast
gates settle it (build, lint, and the single-package test; seconds
rather than minutes). All three true and there is no workaround to
land: do it now.

Raise it instead only when the work genuinely cannot happen now:
it needs a HUMAN DECISION (name the fork and the options), it
lives in another repository or release, or it is materially larger
than the current turn. Then say WHY IT MATTERS, WHAT NEEDS TO
HAPPEN, and WHAT WOULD SETTLE IT, and cite by SYMBOL — never a
line number, a commit SHA or a file inventory, which nothing
recomputes and which go stale and then keep their authority while
lying. The human decides whether it becomes a row, and it is
written once they accept. SURFACING is what stops the defect being
forgotten; filing was only ever a means to that, and as a reflex
it is what grew the open pile to the size of everything ever
completed.

## A gate that cannot fail measures nothing

Never tune a threshold, timeout, or coverage bar until the gate stops
complaining. A silenced gate is worse than no gate: it manufactures
confidence. If a gate is wrong, fix the gate deliberately and say so.

## "Works in CI" is not "works"

An asymmetry between CI and local is where bugs hide. CI checkouts are
clean; developer trees are not. CI has no TTY; developer machines do.
When something passes in one environment and not the other, the
difference IS the finding — chase it rather than papering over it.