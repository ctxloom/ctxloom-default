---
distilled_by: claude-opus-5-5
---
# Deferral Tracking

Deferred work never vanishes silently: it is surfaced to the user, and what they accept lives in taskloom, not in conversation memory or plan prose.

## Search before you create

Before `task_add` — and before proposing one — search the log: `task_list` with `term`, or `tag_query`. Search on the distinctive noun (file, symbol, command, subsystem), not your phrasing — whoever filed it first worded it differently.

If an entry covers the work, UPDATE it (`task_edit`, or append a dated note). Create only when nothing matches.

**Why:** the same defect gets rediscovered from another angle in another session, and a second filing often CONTRADICTS the first with an opposite fix; nobody can later tell which is current. Two tasks disagreeing about one bug is worse than one stale task.

Check even when confident the finding is new.

## Agent deferrals — surface, don't file

Deferred work (descoped, a follow-up found mid-implementation, a postponed fix) goes IN FRONT OF THE USER in your reply, judgeable cold: what it is, why deferred, what should revive it. You do NOT create the task — you PROPOSE (what you found, what should happen), and the row is written once they accept. Surfacing is what stops a deferral vanishing; filing was only a means to that, and as a reflex it grows the open pile to the size of everything ever completed.

**Do it, don't file it — a test, not an estimate** (nobody calibrates "is it small?" the same way twice): already root-caused + code already read + the project's fast gates settle it (build, lint, single-package test; seconds) = do it now. Filing converts a solved problem into work someone pays to rediscover — re-reading code, rebuilding the repro, re-deriving the cause. A filed task looks like progress; it is a promise.

**Propose only when the work can't happen now:** needs a HUMAN DECISION (name the fork and options), lives in another repo/release, or is materially larger than the turn. "I noticed several things" is not a reason.

Once accepted, the revive condition sets the status:

- Concrete condition ("after X merges", "when CI is green") → "Deferred" with that condition as trigger
- No condition, just later → "To Do"

Don't close work that spawned deferrals until each has been put in front of the user.

## User deferrals

When the user defers ("later", "not now", "park it"), offer once, alongside the acknowledgment, to record a taskloom entry; create on confirmation; don't push if declined.

## Why

A deferral living only in your own context (plan file, sub-agent report, intention) dies with the session. Telling the user makes it survive: they can act on it and decide which earn a row. Taskloom is the durable record for what they accept; plans and summaries reference entries by harp ID.
