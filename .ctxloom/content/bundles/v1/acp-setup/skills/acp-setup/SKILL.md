---
name: acp-setup
description: Configure ctxloom's optional ACP (Agent Client Protocol) integration — either serving ctxloom to an editor (Zed, VS Code, Nori, ...), or connecting ctxloom out to a third-party ACP-speaking agent. Use when the user wants an editor's AI panel wired to ctxloom, or wants ctxloom to drive a different ACP-capable engine.
---

# acp-setup

ctxloom's primary interface is its own CLI/TUI (`ctxloom run`) — a working
setup never needs ACP. This skill is for the OPTIONAL, separate step of
wiring ACP (Agent Client Protocol) in, in whichever direction the user
wants. It is never pulled into `ctxloom init`/`/ctxloom-init` automatically;
invoke it (or have the user ask for it) any time.

## Open by asking: server or client?

ACP has two independent directions under ctxloom. Ask the user which one
they want — they may want either, both, or neither (in which case, stop
here):

- **ACP server** — ctxloom SERVES the protocol so an editor's AI panel (Zed,
  VS Code, Nori, ...) connects IN and drives ctxloom sessions: assembled
  context, profiles, and the configured engine, through the editor's own
  chat UI. Go to "ACP server" below.
- **ACP client** — ctxloom CONNECTS OUT to a different ACP-speaking agent (a
  third-party command that itself speaks ACP) and drives it, the same way
  ctxloom drives any other configured engine. Go to "ACP client" below.

These are independent: setting one up implies nothing about the other, and
a project can have both, one, or neither.

## ACP server: an editor connects in

### 1. Detect what's installed

Do your own reconnaissance — this is agentic work, not a ctxloom command.
Check PATH for client binaries/CLIs and well-known config locations for the
clients on the roster below (and any the user names that aren't listed).
Report what you find installed vs. not, rather than assuming.

### 2. Discuss

Ask the user which client(s) they want to use day to day. If their preferred
client isn't installed, offer to help install it: give the install command(s)
(brew/npm/download link/etc. per that client's own docs), but **the user runs
or approves the install themselves — ctxloom never installs a third-party
binary for you.**

Explain trade-offs from the roster below, not from assumption — and note
that the roster is a snapshot; if you can, verify current behavior rather
than trusting a stale line here.

**Client roster** (data, not code — this table is expected to grow over time
via ctxloom-default or a personal bundle, with no ctxloom release required;
for a client not listed here, read its own docs and apply the exact same
discipline below):

| Client | Detect | Docs | Notes (live findings) |
|---|---|---|---|
| Zed | `zed` on PATH; `~/.config/zed/settings.json` | zed.dev/docs | The ACP **reference client** — if a finding looks ambiguous, reproducing it against Zed tells you whether it's ctxloom's bug or the other client's. |
| Toad | `toad` on PATH (or its app config dir) | its own docs | Renders the agent's reasoning/"thinking" stream correctly. |
| Nori | `nori` on PATH; `~/.nori/cli/config.toml` | its own docs | As of the last live check, upstream Nori RECEIVES the thinking stream but renders a spinner instead of the text (a fix has been proposed upstream/as a fork) — don't promise thinking will be visible here without checking current behavior. |
| VSCode | the `formulahendry.acp-client` extension (or ctxloom's own, if installed) | the extension's marketplace page | Configure via VS Code's own settings UI/JSON for that extension. |

### 3. Configure — the write discipline (read this before writing anything)

Two different configs are in play here, and they are never written the same
way:

- **ctxloom's own config** (anything under this project's `.ctxloom/`) —
  always via ctxloom's own CLI (`ctxloom agent set`, `ctxloom profile
  create`, …). Tested code, ctxloom's domain, never hand-edited.
- **The third-party client's config** (Zed's settings.json, Nori's
  config.toml, VSCode's extension settings, or any client not listed above) —
  configured by YOU (the agent), never by ctxloom, in this strict priority
  order:

  1. **PREFERRED: the client's OWN configuration CLI.** If the client ships
     a config command (`<client> config set …`, an `agents add` subcommand,
     whatever it calls it), USE IT. Discover it from that client's own
     `--help` or docs. The client's authors' own tested code owns its path,
     format, and merge behavior — that is strictly safer than you touching
     the file yourself, and it's the same "mimic the CLI's native surface"
     rule this project already follows for engines.
  2. **FALLBACK — only when the client ships no config CLI at all:** a
     direct file edit, but never freehand. Resolve the client's REAL
     per-OS config path yourself (from its docs — never trust an
     env-overridden `$HOME`, never guess), confirm the exact path and the
     exact change with the user, then delegate the actual filesystem
     mechanics to ctxloom's guarded primitive rather than writing the file
     yourself:

     ```
     echo '<json patch>' | ctxloom util config-write --file <resolved path> --filetype json
     ```

     (`--filetype toml` for a TOML target, e.g. Nori's config.toml.) This
     hidden command is TESTED CODE that does the dangerous part correctly
     every time: it backs the file up with a fresh timestamped copy before
     touching it, parses the existing file and deep-merges your patch
     (never truncates, never regenerates the file wholesale, every foreign
     key survives), refuses outright and leaves the original bytes
     untouched if the existing file fails to parse, and after writing
     re-reads the file and confirms your entry is actually there before
     reporting success. That is why the fallback is safe to use at all —
     the risky mechanics are code you call, not prose you followed by hand.
     Show the user the reported backup path.

  Never do both for the same fact, and never hand-roll the fallback
  yourself (no ad hoc file writes) — always go through `ctxloom util
  config-write` when there is no client config CLI.

- **What ctxloom gives you to write:** ctxloom emits only **frontend-neutral**
  connection info — it does not know or care what any client's format looks
  like. Get it from:

  ```
  ctxloom acp entries --format json
  ```

  Each entry has `name`, `command`, `args` (plus `agent`/`engine`/`profiles`
  when the entry is a named agent binding). You adapt that neutral fact into
  whatever shape the chosen client wants — a Zed `agent_servers` entry, a
  Nori `[agents.x]` TOML table, a VSCode extension setting, or the client
  registration format of an editor that doesn't exist yet. A permanent entry
  named after this skill (`acp-setup`) is worth adding alongside whichever
  working agent(s) the user wants to reach day to day.

  The `command`/`args` pair the entry names doesn't have to be the local
  `ctxloom` binary. Two options, and it's the user's call which:
  - The local binary — what `--format json` reports — if `ctxloom` is on
    the user's PATH already.
  - **`npx -y ctxloom acp server`** — zero-install: no local binary, nothing
    on PATH, and no version skew between what the client spawns and whatever
    actually shipped, once ctxloom is published to npm. Treat that "once
    published" as real — verify it's actually on npm before promising this
    works, the same live-check discipline as the client roster above; if
    it isn't yet, say so and fall back to the local-binary form.

- Standing rules regardless of path taken: never write anything the user
  hasn't agreed to; treat empty or failed output as a failure to surface
  (never claim a write happened without proof); on a re-run, merge with what
  you find rather than re-scaffolding.

### 4. Verify — the exit criterion

Before moving on: at least one client entry must be **written, re-read back,
and confirmed well-formed** — and, if practical in this session, proven with
a live connect (have the user open that client and confirm a session
starts). Don't treat "I wrote something" as done; treat "I confirmed it's
there and it works" as done.

## ACP client: ctxloom connects out to an ACP-speaking agent

This is the OTHER direction: ctxloom itself becomes an ACP client, spawning
a third-party command that speaks ACP (`kiro-cli acp`, `claude-code-acp`,
`codex-acp`, or any future `<agent> acp`) and driving it exactly as it
drives any other configured engine — assembled context rides the first
turn, sessions record under ctxloom harp names. Structured/headless only:
there is no TUI for this direction, so it never replaces an interactive
`ctxloom run` session against a native engine.

### 1. Vet the target before configuring anything

The target is third-party code sitting on the ctxloom↔engine seam — it sees
the whole session: every prompt, every tool call, and whatever credentials
or tokens live in its own environment. That is a higher-trust supply-chain
surface than an editor client the user picked for their own use, so don't
configure one blind — **prompt the user, and vet it first:**

1. **Read the source before installing.** For the specific target AND
   version you'd configure, fetch and read its actual source (the npm
   package contents / its repository at that version) and review it for
   what an ACP agent has no business doing: network calls to hosts other
   than the model provider it's meant to reach; reading credentials or env
   beyond what it needs; spawning unexpected processes; install/postinstall
   scripts; code shipped only minified/obfuscated with no readable source.
   Summarize what you found for the user, plainly — including "I could not
   fully review X."
2. **Be honest about the limit.** Reading the repo source does not prove
   the published package matches it, and you are not a safety guarantee —
   you are surfacing risk for the user's informed decision. **Pin a
   specific version** (never a floating `latest`) so what you reviewed is
   what installs.
3. **The user installs — never ctxloom, never you silently.** Give the
   exact pinned command; the user runs or approves it.

If a target doesn't clear the user's bar, say so and name the trade rather
than pushing the install.

### 2. Configure the `llm:` entry

An ACP-client target is a normal ctxloom `llm:` config entry, of
`type: acp` — same status as any `claude-code`/`antigravity`/`codex` entry,
just driving a generic ACP-speaking command instead of a fixed vendor
binary. There is no dedicated `llm add`/`llm set` command yet, so add it the
sanctioned way for a config field with no CLI setter: `ctxloom config edit`
(opens `.ctxloom/config.yaml` in `$EDITOR`) — never a freehand file write
outside that.

Add or update, under `llm:` in `.ctxloom/config.yaml`:

```yaml
llm:
  configs:
    kiro-acp:                       # the label you'll reference elsewhere
      type: acp
      command: "kiro-cli acp"       # the target's ACP-mode invocation
      agent_engine: kiro            # optional: names the target for other lookups
      # model: "claude-sonnet"      # optional: requested model
      # model_env_var: ANTHROPIC_MODEL  # optional: ALSO deliver model via this env var
```

Only `command` is required. The label (`kiro-acp` above) is yours to choose
— it's what `--llm <label>` on `run`/`map`/`weave`/`acp client` names.

### 3. Smoke-test before wiring it into an agent binding

```
ctxloom acp client --llm kiro-acp "reply with exactly: ok"
```

This drives ONE headless turn against the configured label through
ctxloom's normal engine-launch path (the same one `ctxloom run --llm
kiro-acp` would use) — confirm it actually answers before binding it into
an `ctxloom agent set <name> --engine kiro-acp …` for regular use. A
failure here (spawn error, protocol error, empty reply) means the vetting
step above wasn't enough or the config is wrong — don't wire a silently
broken engine into an agent.

### 4. Verify — the exit criterion

Same discipline as the server direction: don't treat "I wrote the config"
as done. The smoke test above must have actually returned a reply, and if
the user wants it as a real agent binding, `ctxloom agent list`/`ctxloom
agent show <name>` must confirm the binding resolved.
