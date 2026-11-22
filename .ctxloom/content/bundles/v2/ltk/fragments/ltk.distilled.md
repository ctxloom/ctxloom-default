---
source_sha256: da86b8675278e946f7a25c66801a7973147c79ce80887f733a9628ede3a59001
---
# llm-tool-killer (ltk)

- Pre-tool hook: inspects each shell command before execution; redirects on rule match. ctxloom shapes context seen; ltk guides commands run.
- Config: `.ltk/config.yaml`. Parses real command (resolves vars, unwraps trivial wrappers/sub-shells), matches rules. First matching `deny` wins, returns `message`/`suggest` with what to run instead.
- Example: `go test ./...` → blocked: "Run tests through the task runner." → retry `just test`.

## Working with it
- Redirect = guidance, not failure. Read suggestion, retry as rule asks.
- Prefer task runner (e.g. `just <target>`) over direct build/test/lint tools.
- Agents do not cut releases. ltk blocks `git tag` and release commands. Prepare version bump and PR; human or CI cuts tag.

## Not
- Cooperative redirect, not sandbox. Agent can work around a rule if explicitly instructed. Makes easy/accidental path the right one; not hard isolation.
- Strict "never" boundaries: run agent in container.
