---
distilled_by: claude-haiku-4-5-20251001
---
# ltk

**llm-tool-killer (ltk)** — pre-tool hook that inspects and redirects shell commands per `.ltk/config.yaml` rules.

## How it works

Parses real command (resolving variables, unwrapping wrappers) → matches against project rules → first matching `deny` returns `message`/`suggest`:

    go test ./...   →   blocked: "Run tests through the task runner."
                    →   retry: `just test`

## How to use

- Treat redirects as guidance; read suggestion and retry as specified
- Prefer project task runner (`just <target>`) over invoking tools directly  
- **Agents do not cut releases** — ltk blocks `git tag`/release commands; prepare version bump/PR for human or CI

## What it is not

Cooperative redirect, not a sandbox. Explicit workarounds are possible; for strict boundaries use a container.