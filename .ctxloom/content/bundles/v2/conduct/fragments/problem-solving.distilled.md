---
source_sha256: 62d744196910845395f443492fd1e5cadf95a1985c0a5d427736f6b6e680f88c
---
# Workarounds and Problem Solving

**Core principle:** Find the root cause before choosing a solution. Fix problems at the source.

## When functionality fails
1. **Find the root cause first.** No workarounds without asking; investigate and identify the actual source.
2. **Ask before complex fixes to simple problems.** If a simple problem seems to need a complex solution, stop and ask.
3. **Prompt for guidance** with options: proper fix (estimate effort), workaround (document trade-offs), temporarily disable test (document why), alternative approaches.
4. **Cost/benefit analysis:** pros/cons per option, tech debt, maintainability impact, time investment.
5. **Document the decision** and reasoning for the chosen path.

## A comment justifying a workaround is an unreported bug report
If you write a comment explaining WHY a workaround is needed, you've diagnosed a real defect. Writing it down isn't reporting it. Routing around the bug turns the comment into a tombstone: readers take it as settled fact and the cause survives.

Shapes this takes:
- arbitrary cap/limit with a justifying comment
- retry, sleep, or poll around something that should be deterministic
- "without this, X breaks" note
- threshold tuned down until a gate stops failing
- fallback that turns a real failure into silence
- re-implementation of another tool's private behaviour

## A workaround is not DONE until all three
1. **Escalate before landing it.** Name the real bug and where it lives. The workaround is locally cheaper than escalating, which is why this rule is needed.
2. **Dispose of the root cause: fix it, or raise it with the human.** Not "file it": don't create a task on your own initiative. Carry the diagnosis from the comment into either the fix or what you present to the human. An unreported root cause is a bug you've agreed to forget.
3. **The comment states the invariant, not the history.** If you can't state an invariant, you don't have a fix, you have a scar.

**Prefer the fix.** The bar is a test, not an estimate: the root cause is already diagnosed (the comment proves it), the fix touches code already read, and fast gates (build, lint, single-package test; seconds, not minutes) settle it. If all three hold, do it now.

**Raise it only when** the work genuinely can't happen now:
- it needs a human decision (name the fork and options)
- it lives in another repository or release
- it is materially larger than the current turn

Then state WHY IT MATTERS, WHAT NEEDS TO HAPPEN, and WHAT WOULD SETTLE IT. Cite by **symbol**, never line number, commit SHA, or file inventory, since those go stale and keep their authority while wrong. The human decides whether it becomes a row; it is written once they accept. Surfacing prevents the defect being forgotten; filing was only a means to that. As a reflex, filing is what grew the open pile to the size of everything ever completed.

## A gate that cannot fail measures nothing
Never tune a threshold, timeout, or coverage bar until the gate stops complaining. A silenced gate manufactures confidence. If a gate is wrong, fix the gate deliberately and say so.

## "Works in CI" is not "works"
CI-vs-local asymmetries hide bugs. CI checkouts are clean; developer trees aren't. CI has no TTY; developer machines do. When something passes in one environment and not the other, the difference is the finding. Chase it, don't paper over it.
