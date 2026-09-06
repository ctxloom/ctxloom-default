---
description: 'Run a parallel, synthesized code review: fan per-lens reviewers with `ctxloom weave` and reduce with cr-synthesis (agent-driven, language-aware).'
tags:
  - review
  - weave
---
# Weave Code Review

Run a parallel, synthesized code review by fanning per-lens reviewers
with `ctxloom weave`, then reducing their findings into one report. Each
lens looks at the change independently, in parallel, and a synthesis step
de-duplicates and ranks. You (the orchestrating agent) drive this end to
end — the weave output IS the review; do not also review inline.

## 1. Get the diff
Use the change under review: `git diff` (working tree), `git diff
--staged`, or `git diff <base>...HEAD` for a branch/PR. Honor a range the
user named.

## 2. Detect the project's language(s)
Scan for markers: go.mod, Cargo.toml, package.json, pyproject.toml,
pom.xml, *.csproj, Package.swift, CMakeLists.txt, etc. A polyglot repo has
several — review only the language(s) actually present in the diff.

## 3. Find the review members to fan
The reviewers are built ONCE — at `ctxloom init` / `ctxloom subagent
setup` — and persisted locally, a discrete per-(lens × language) member
each (conduct + thorough + that lens's `general` fragment + the language
fragment). You do NOT compose them here; you fan what is already
persisted. The `code-review-base#fragments/thorough` fragment makes each
reviewer read every file rather than trust summaries/memories/names. Find the
members for the language(s) in the diff:
- `ctxloom subagent list` and `ctxloom profile list` — the persisted local
  review members, plus any per-lens subagents with a chosen engine and the
  `cr-synthesis` reduce member.

If this project has no review members yet, they haven't been built: run
`ctxloom subagent setup` (or ask the user to) to compose and persist them
for this project's language(s), then return here. For a one-off without an
ensemble, run the single-agent `cr-all` profile instead.

## 4. Fan and synthesize
Fan the members in parallel and reduce with the synthesis profile:

    ctxloom weave -p <member1> -p <member2> ... -s cr-synthesis "<diff>"

- `-p <member>` is bare-profile sugar (a default-engine member); if the
  user has a same-named local subagent, its chosen engine wins.
- `-s cr-synthesis` is the reduce step — bind a high-power engine there.
- Pass or pipe the diff as the task.

## 5. Report
Surface the synthesized report: a summary + merge recommendation, then
Critical / Major / Minor findings (each with `file:line`, the consequence,
the fix, and which lens raised it), and notable strengths.