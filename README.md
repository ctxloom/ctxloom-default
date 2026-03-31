# ctxloom-default

Default bundles and profiles for [ctxloom](https://github.com/ctxloom/ctxloom).

## Usage

This remote is pre-configured in ctxloom. After `ctxloom init`, you can use profiles directly:

```yaml
# .ctxloom/config.yaml
defaults:
  profiles:
    - ctxloom-default/go-developer
```

Or pull content manually:

```bash
# Pull a profile
ctxloom remote pull ctxloom-default/go-developer --type profile

# Pull a bundle
ctxloom remote pull ctxloom-default/testing --type bundle
```

## Available Profiles

| Profile | Description |
|---------|-------------|
| go-developer | Go backend development with testing, 12-factor, tooling |
| go-code-reviewer | Go code review with checklists |
| python-developer | Python development with modern tooling (uv, pipx) |
| python-code-reviewer | Python code review with checklists |
| rust-developer | Rust systems development with tooling |
| rust-code-reviewer | Rust code review with checklists |
| typescript-web-developer | TypeScript/React web development |

## Available Bundles

| Bundle | Description |
|--------|-------------|
| 12-factor | Cloud-native application methodology |
| asdf | Version manager for multiple runtimes |
| ast-grep | Structural code search and replace |
| code-review-checklists | Review perspectives (architecture, performance, etc.) |
| configuration-patterns | Type-discriminated config, validation, layering |
| cqrs | Command Query Responsibility Segregation |
| git | Git practices and workflows |
| lsp | Language Server Protocol for AI agents |
| mcp-browser-playwright | Browser automation MCP server |
| mcp-tasks | Task management MCP server |
| python-development | Python style, testing, tooling |
| rtk | Rust Token Killer output optimization |
| rust-development | Rust idioms and tooling |
| security | Security checklist and practices |
| sequential-thinking | Structured reasoning MCP server |
| testing | TDD, Gherkin, test organization |
| typescript-development | TypeScript strict mode and conventions |
| web-frontend | React, Vite, ESLint patterns |

## Prompts

| Prompt | Description |
|--------|-------------|
| code-review | Comprehensive code review |
| code-review-recent | Review recent changes |
| distill | Text compression utility |
| write-readme | README generation |

## License

MIT
