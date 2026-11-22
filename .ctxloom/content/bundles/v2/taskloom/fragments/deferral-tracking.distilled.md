---
source_sha256: 64070ec9becdb229919dceaf118aa433cc15f8d6103ff25ce8a5476f90312807
---
# Deferral Tracking

Deferred work is surfaced to the user; accepted items live in taskloom, not in conversation memory or plan prose.

## Search before creating
- Before `taskloom add` (and before proposing one), search the log: `taskloom list --all --term <noun>` or `--tag-query` (postfix, e.g. `area:cli/human:decision/and`).
- Search on the distinctive noun (file, symbol, command, subsystem), not your own phrasing. Others likely worded it differently.
- If something covers the work, UPDATE it (`taskloom edit <harp> <text>`, or append a dated note) instead of filing a second entry. Create only when nothing matches.
- Why: duplicates accumulate, and a second filing can contradict the first with an opposite fix. Two conflicting tasks are worse than one stale task.
- Check for an existing entry even when the finding seems new.

## Agent deferrals: surface, don't file
- Deferred work (descoped, mid-implementation follow-up, postponed fix) goes in front of the user in your reply: what it is, why deferred, what should revive it.
- Do NOT create the task. PROPOSE it (what you found, what should happen); write the row only after the user accepts. Surfacing prevents silent loss; filing as a reflex bloats the open pile.
- Do-it-don't-file test. Do it now if ALL hold:
  - root cause already found
  - fix touches code already read
  - fast gates settle it (build, lint, single-package test; seconds, not minutes)
- Propose only when work cannot happen now: needs a HUMAN DECISION (name the fork and options), lives in ANOTHER REPOSITORY or RELEASE, or is MATERIALLY LARGER than the current turn. "I noticed several things" is not a reason.
- After acceptance, the revive condition sets status:
  - Concrete condition ("after X merges", "when CI is green"): Deferred with trigger, via `taskloom add --trigger "<condition>" <text>` or `taskloom status <harp> --trigger "<condition>"`.
  - No condition, just later: "To Do" (default for `taskloom add`).
- Don't close out work that spawned deferred items until each has been surfaced to the user.

## User deferrals
- When the user defers something ("later", "not now", "punt on that", "park it"), offer once, briefly, to record it as a taskloom entry; create on confirmation. Don't push if declined.

## Why
- A deferral living only in your context (plan file, sub-agent report, intention) dies with the session. Telling the user makes it survive: they act on it and decide which deferrals earn a row. Plans and summaries reference entries by harp ID.
