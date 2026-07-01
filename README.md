# ctxloom-default

Default bundles and profiles for [ctxloom](https://github.com/ctxloom/ctxloom).

## Usage

This remote is pre-configured in ctxloom. `ctxloom init` seeds a local `default`
coding profile (inheriting the base profiles below) and, working with your agent,
composes the language developer(s) and code-review members your project needs from
these bundles — rather than shipping a fixed matrix of per-language profiles.

```bash
# Pull a bundle
ctxloom remote pull ctxloom-default/testing --type bundle
```

## Profiles

Profiles ship **inside bundles**, addressed as `<bundle>#profiles/<name>`.
ctxloom-default provides composition roots and exemplars; `ctxloom init` composes
the project-specific language developers and review members from the fragment
bundles.

| Profile | Description |
|---------|-------------|
| `default#profiles/default` | Baseline conduct/practices + sequential-thinking MCP (seeded by init) |
| `ai-developer#profiles/developer` | Developer composition root — compose with a `<lang>-ai-practices` bundle |
| `code-review-base#profiles/cr-all` | Comprehensive single-agent code review (all lenses) |
| `code-review-base#profiles/cr-synthesis` | Synthesis/reduce step for a `ctxloom weave` review ensemble |

## Available Bundles

| Bundle | Description |
|--------|-------------|
| 12-factor | Cloud-native application methodology |
| agent-roles | finder + developer-escalation role fragments for orchestrated subagents |
| asdf | Version manager for multiple runtimes |
| ast-grep | Structural code search and replace |
| code-review-base | Review scaffolding (conduct + synthesis) and the cr-all/cr-synthesis exemplar profiles |
| code-review-\<lens\> | Per-lens review fragments (general + per-language) to compose `ctxloom weave` members |
| code-review-checklists | Review perspectives (architecture, performance, etc.) |
| configuration-patterns | Type-discriminated config, validation, layering |
| cqrs | Command Query Responsibility Segregation |
| git | Git practices and workflows |
| lsp | Language Server Protocol for AI agents |
| mcp-browser-playwright | Browser automation MCP server |
| python-development | Python style, testing, tooling |
| rtk | Rust Token Killer output optimization |
| rust-development | Rust idioms and tooling |
| security | Security checklist and practices |
| sequential-thinking | Structured reasoning MCP server |
| testing | TDD, Gherkin, test organization |
| typescript-development | TypeScript strict mode and conventions |
| web-frontend | React, Vite, ESLint patterns |

## Skills

| Skill | Description |
|-------|-------------|
| weave-review | Parallel synthesized code review — fans per-lens reviewers via `ctxloom weave` + `cr-synthesis` (bundle skill in `code-review-base`) |
| review-perspectives | Comprehensive single-agent code review (multi-perspective) |
| review-recent | Review recent changes |
| review-illuminated | Interactive step-by-step code-review walkthrough |
| distill | Text compression utility |
| write-readme | README generation |

## License

MIT
