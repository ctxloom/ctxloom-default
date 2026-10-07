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
ctxloom-default provides composition roots, exemplars, and a `<lang>-developer` profile
for each language bundle; `ctxloom init` composes
the project-specific language developers and review members from the fragment
bundles.

| Profile | Description |
|---------|-------------|
| `ai-developer#profiles/developer` | Developer composition root — compose with a `<lang>-ai-practices` bundle |
| `code-review-base#profiles/cr-all` | Comprehensive single-agent code review (all lenses) |
| `code-review-base#profiles/cr-synthesis` | Synthesis/reduce step for a `ctxloom weave` review ensemble |
| `code-review-base#profiles/cr-thorough` | cr-all + thorough + conduct + code-quality: the ctxloom-default half of a language reviewer |
| `agent-roles#profiles/coordinator` | ctxloom-default half of a coordinator agent (conduct, sequential-thinking, structural review, ltk) |
| `agent-roles#profiles/finder` | ctxloom-default half of a finder agent (finder role, ast-grep, rtk) |
| `go-ai-practices#profiles/go-developer` | Go developer: `developer` + conduct + code-quality + go-ai-practices |
| `python-development#profiles/python-developer` | Python developer: `developer` + conduct + code-quality + python-development |
| `rust-development#profiles/rust-developer` | Rust developer: `developer` + conduct + code-quality + rust-development |
| `typescript-development#profiles/typescript-web-developer` | TypeScript web developer: `developer` + conduct + code-quality + typescript-development |
| `conduct#profiles/website-author` | ctxloom-default half of a docs/website author |

## Available Bundles

| Bundle | Description |
|--------|-------------|
| acp-setup | Skill package for configuring ctxloom's optional ACP (Agent Client Protocol) integration |
| agent-roles | finder + developer-escalation role fragments for orchestrated subagents |
| asdf | Version manager for multiple runtimes |
| ast-grep | Structural code search and replace |
| cli-ux | Skill package for designing/auditing command-line interfaces against ten CLI-UX principles |
| code-review-base | Review scaffolding (conduct + synthesis) and the cr-all/cr-synthesis exemplar profiles |
| code-review-\<lens\> | Per-lens review fragments (general + per-language) to compose `ctxloom weave` members |
| git | Git practices and workflows |
| mcp-browser-playwright | Browser automation MCP server |
| python-development | Python style, testing, tooling |
| rtk | Rust Token Killer output optimization |
| rust-development | Rust idioms and tooling |
| sequential-thinking | Structured reasoning MCP server |
| testing | TDD, Gherkin, test organization |
| typescript-development | TypeScript strict mode and conventions |
| web-frontend | React, Vite, ESLint patterns |

## Skills

| Skill | Description |
|-------|-------------|
| weave-review | Parallel synthesized code review — fans per-lens reviewers via `ctxloom weave` + `cr-synthesis` (bundle skill in `code-review-base`) |
| apply-cli-ux-principles | Design/audit a CLI against ten CLI-UX principles (bundle skill in `cli-ux`) |
| acp-setup | Configure ctxloom's optional ACP integration — serving an editor, or connecting out to an ACP-speaking agent (bundle skill in `acp-setup`) |
| review-perspectives | Comprehensive single-agent code review (multi-perspective) |
| review-recent | Review recent changes |
| review-illuminated | Interactive step-by-step code-review walkthrough |
| distill | Text compression utility |
| write-readme | README generation |

## License

MIT
