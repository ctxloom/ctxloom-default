---
distilled_by: claude-haiku-4-5-20251001
---
# Deferral Tracking

Deferred work is surfaced to the user; what they accept lives in taskloom, not in conversation memory or plan prose.

## Search before you create

Before `task_add` — and before proposing one — search existing log using `task_list` (term filter) or `tag_query` on distinctive noun: file, symbol, command, subsystem.

If entry covers the work, UPDATE it (`task_edit`, append dated note). Create only when nothing matches.

**Critical:** Duplicates generate contradictory fixes; whoever picks up later cannot tell which is current.

Check for existing entry even when confident finding is new.

## Agent deferrals — surface, don't file

Deferred work (descoped, mid-implementation, postponed) goes IN FRONT OF THE USER in your reply: what it is, why deferred, what should revive it. You do NOT create the task — you PROPOSE, and the row is written once they accept. Surfacing is what stops a deferral vanishing; filing was only ever a means to that.

**Do it, don't file it — a test, not an estimate:** already root-caused + code already read + the project's fast gates settle it (build, lint, single-package test) = do it now. Filing converts a solved problem into work someone pays to rediscover.

**Propose only when the work can't happen now:** needs a HUMAN DECISION (name the fork and options), lives in another repo/release, or is materially larger than the turn. "I noticed several things" is not a reason.

Once accepted, the revive condition sets the status:

- Concrete revive condition ("after X merges", "when CI green") → "Deferred" status with condition as trigger
- No condition → "To Do"

Don't close work spawning deferrals until each has been put in front of the user.

## User deferrals

Offer brief taskloom entry when user defers. Create on confirmation. Don't push if declined.

## Durability

Deferrals living only in your own context (plan file, sub-agent report, intention) disappear when the session ends; telling the user is what makes them survive, and they decide which earn a row. Taskloom is the durable record for accepted work; summaries reference by harp ID.