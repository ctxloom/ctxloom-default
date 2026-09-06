---
tags:
  - tasks
  - workflow
content_hash: sha256:ee2b4d1af5c617d7afeb315c7cda6b550df29e017f97b430f21a5d5e12e95805
---
# Deferral Tracking

Deferred work does not vanish silently: it is surfaced to the user, and what they accept lives in taskloom rather than in conversation memory or plan prose.

## Search before you create

Before `task_add` — and before you propose one — search the existing log. Use `task_list` with a `term` filter, or a `tag_query`, and search on the distinctive noun — the file, symbol, command or subsystem — not on your own phrasing of the problem. Whoever filed it first almost certainly worded it differently.

If something already covers the work, UPDATE it (`task_edit`, or append a dated note to its text) rather than filing a second entry. Create only when nothing matches.

Why this matters more than it sounds: backlogs accumulate duplicates fast, because the same defect gets rediscovered from a different angle in a different session. The failure mode is not just clutter — a second filing often *contradicts* the first, prescribing an opposite fix, and whoever picks them up later has no way to tell which is current. Two tasks disagreeing about the same bug is worse than one stale task.

Check for an existing entry even when you are confident the finding is new.

## Agent deferrals — surface them, do not file them

When work gets deferred in a session — descoped from the current task, a follow-up discovered mid-implementation, a fix postponed — it goes IN FRONT OF THE USER, in your reply, with enough context to judge it cold: what it is, why it was deferred, and what should revive it.

You do NOT create the task. A task is created with the user's agreement: you PROPOSE — say what you found and what you think should happen — and the row is written once they accept. SURFACING is what stops a deferral vanishing silently; filing was only ever a means to that, and as a reflex it is what grows an open pile to the size of everything ever completed.

Before you propose anything, apply the do-it-don't-file test. It is a test rather than an effort estimate, because nobody calibrates "is it small?" the same way twice:

- you have ALREADY root-caused it, AND
- the fix touches code you have ALREADY read, AND
- the project's fast gates settle it — build, lint, and the single-package test; seconds rather than minutes

All three true? DO IT NOW. Filing instead converts a solved problem into work someone pays to rediscover: they must re-read the code, rebuild the reproduction, and re-derive the cause you already had in hand. A filed task looks like progress. It is a promise.

Propose one only when the work genuinely cannot happen now: it needs a HUMAN DECISION (name the fork and the options), it lives in ANOTHER REPOSITORY or another RELEASE, or it is MATERIALLY LARGER than the current turn. "I noticed several things" is not a reason.

Once the user accepts, the revive condition sets the status:

- A concrete condition exists ("after X merges", "when CI is green") → status "Deferred" with that condition as the trigger.
- No condition, just later → "To Do".

Don't close out work that spawned deferred items until each one has been put in front of the user.

## User deferrals

When the user defers something ("later", "not now", "punt on that", "park it"), offer to record it as a taskloom entry and create it on confirmation. One short offer alongside the acknowledgment; don't push if declined.

## Why

A deferral that lives only in your own context — a plan file, a sub-agent's report, an intention to come back to it — dies with the session. Telling the user is what makes it survive: they can act on it, and they decide which deferrals earn a row. The task log is the durable record for what they accept; plans and summaries reference entries by harp ID.
