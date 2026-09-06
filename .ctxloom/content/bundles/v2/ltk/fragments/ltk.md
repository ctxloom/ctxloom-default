---
tags:
  - ltk
  - tooling
notes: |-
  Written because a pre-tool deny looks like a failure to an agent
  that has never met one: the failure defended against is treating
  the redirect as an obstacle — rewrapping or sub-shelling the
  command past the rule — instead of reading the suggestion and
  retrying as asked. The release rule is singled out because
  `git tag` has no acceptable retry: the right response is to stop
  and leave the tag to a human or CI. "What it is not" is there so
  nobody mistakes cooperative redirection for a security boundary;
  strict isolation needs a container. Origin: derived from the
  body; no incident behind it.
content_hash: sha256:097c1e35d3792346b91684ca81f613179c39abe07f361367a982a33317a212bb
---
# llm-tool-killer (ltk)

This project may run **ltk**, a pre-tool hook that inspects each shell
command before it executes and redirects it when a rule matches. Where
ctxloom shapes the context you see, ltk guides the commands you run.

## What it does

ltk parses the real command (resolving variables, unwrapping trivial
wrappers and sub-shells) and matches it against the project's rules in
`.ltk/config.yaml`. The first matching `deny` wins and returns a
`message`/`suggest` telling you what to run instead. Example:

    go test ./...   ->   blocked: "Run tests through the task runner."
                    ->   retry with `just test`

## How to work with it

- Treat a redirect as guidance, not a failure: read the suggestion and
  retry the command the way the rule asks.
- Prefer the project's task runner (e.g. `just <target>`) over invoking
  build/test/lint tools directly.
- **Agents do not cut releases.** ltk blocks `git tag` and release
  commands. Prepare the version bump and PR; a human (or CI) cuts the tag.

## What it is not

ltk is a cooperative redirect, not a sandbox. If explicitly instructed to
work around a rule the agent can, so it makes the easy, accidental path
the right one rather than enforcing hard isolation. For strict "never"
boundaries, run the agent in a container.
