---
name: apply-cli-ux-principles
description: Apply ten CLI-UX principles when designing, building, or reviewing a command-line interface — help that teaches, progressive disclosure, honest defaults, consistent grammar, discoverability, teaching errors, stream and exit-code contracts, machine escape hatches, closed tag/label loops, and compatibility discipline. Use when adding or changing CLI commands, flags, help text, or output, or when auditing a CLI's usability.
---

# Apply CLI-UX principles

Use this when you design a new command, change flags or output, or review a CLI
for usability. Each principle below is a rule plus the check that catches its
violation. Run the checks against the actual binary — invoke it, pipe it, trip
its errors — not against the source.

The failure modes these guard against: help that inventories flags instead of
teaching the task, defaults that silently drop data the user asked for, errors
that describe the wall instead of the door, and output that can't be piped.

## The ten principles

1. **Help teaches; it does not merely inventory.** Lead help with a worked
   example, not an alphabetical flag dump. Any flag whose value has its own
   syntax (a query, a selector, a format string) must carry inline examples of
   that syntax — three or more worked expressions.
   *Check:* can a first-time user get from `tool --help` to a non-trivial
   success without reading anything else?

2. **Progressive disclosure.** The 90% path needs zero flags. A bare command
   does the obvious thing; flags refine; an advanced sub-language exists but is
   never required.
   *Check:* what does the bare command with no arguments do? "Error" or
   "nothing useful" means the defaults are wrong.

3. **Sensible defaults — and a default that hides data must say so.** View
   defaults (show active, hide done; show local, hide remote) are usually
   right. But when an explicit query matches items the default view then
   suppresses, print a one-line count and the flag that reveals them —
   `12 shown; 30 more match but are completed — add --all`. Never return an
   empty result from data that exists.
   *Check:* run a query that matches only hidden items. Does the tool say what
   it hid and how to see it, or just print nothing?

4. **Consistent grammar: one word per concept, everywhere.** If `--json`
   selects machine output in one command, no sibling may spell it
   `--format json` or `-o json`. Plural nouns list; argument order is stable
   (`tool verb <id> [modifiers]`). The measure is guessability.
   *Check:* take a flag from one subcommand and predict its name and behavior
   on a sibling. Were you right?

5. **Discoverability: every feature reachable from `--help` alone.** The help
   tree must mention each capability at least once. Any value-set the user must
   supply from (statuses, tags, remotes, contexts) needs a command that
   enumerates it — no write-only vocabularies.
   *Check:* for every value-set a flag accepts, is there a command that lists
   the current values?

6. **Errors are teachers: what failed, why, and the next command.** The
   template is *what was wrong → why → the concrete next step*, named in the
   tool's own flag vocabulary ("pass --add <tag> and/or --remove <tag>", not
   "at least one tag required"). A query parse error points back at the query
   syntax help with a valid example.
   *Check:* trigger each error path. Does every message end with an actionable
   next step?

7. **Streams and exit codes are contracts.** stdout is data; stderr is
   commentary (hints, warnings, progress) so pipes stay clean. Exit 0 means the
   operation succeeded *and delivered its effect* — a run that succeeded at
   doing nothing the user asked is not a success; never print an error and exit
   0. Quiet by default: no banner, one line per fact.
   *Check:* pipe every read command to a consumer — does non-data leak into
   stdout? Grep error paths for a forgotten nonzero exit.

8. **Human-first output with a machine escape hatch.** Default output is
   aligned and scannable for eyes. Every read command also offers a stable
   `--json` whose schema is the compatibility surface. Never make humans parse
   JSON; never make scripts parse the human table.
   *Check:* does every listing have `--json`? Is the human form self-describing
   (`3 active`, not a bare `3`)?

9. **Tags/labels/filters: the full loop or nothing.** A tagging system needs
   all four verbs — attach/detach (symmetric), enumerate (with counts, which
   expose typo-twins like `release` 40 / `realease` 1), filter (composable),
   and display (visible in normal listings). If the filter step has its own
   expression syntax, it needs inline examples for AND, OR, NOT, and one
   composed expression (see principle 1).
   *Check:* walk the loop — attach, list, filter, see it in output, detach.
   Any missing verb breaks it.

10. **Never break the installed base casually.** Additive changes (a new
    subcommand, a stderr hint, richer help, a new flag) are always safe.
    Renames, repurposed flags, and flipped defaults invalidate scripts and
    muscle memory — they need a deprecation story and an explicit decision, not
    routine polish.
    *Check:* would an existing script or habit behave differently? If yes, it
    needs sign-off.

## How to use this skill

- **Designing** a command or flag: check the proposal against principles 1, 2,
  4, and 7 before writing code — they constrain the shape (bare-command
  behavior, flag naming, stream discipline). Then 5 and 8 for the read side.
- **Auditing** an existing CLI: run the checklist below top to bottom against
  the real binary. Report each violation with the principle number, the exact
  invocation that exposes it, and the observed vs. expected behavior.

## Audit checklist

- [ ] `--help` alone gets a new user to a successful real invocation.
- [ ] Every mini-language flag (queries, selectors, formats) has three or more inline worked examples.
- [ ] Bare invocation of each read command does something useful.
- [ ] No default silently hides items an explicit query matched — hidden-match count and revealing flag are printed.
- [ ] Flag names, output shapes, and argument order are guessable across sibling commands.
- [ ] Every value-vocabulary a flag accepts has an enumeration command.
- [ ] Every error message names the concrete next step in flag vocabulary.
- [ ] stdout carries only data; hints/warnings/provenance go to stderr; exit codes truthful.
- [ ] Every listing has `--json`; human output is self-describing.
- [ ] Tag/label loop closed: attach, enumerate (with counts), filter, display.
- [ ] No command renames or default flips without an explicit compatibility decision.

The full reference — rationale and exemplars from git, gh, docker, kubectl, and
taskwarrior for each principle — is in `docs/cli-ux-principles.md` in the
ctxloom repository. Read it when a check is contested or you need the reasoning
behind a rule.
