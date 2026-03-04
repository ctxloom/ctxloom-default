# scm-github

SCM context fragments, prompts, and profiles for AI-assisted development.

## Usage

Add this repository as a remote source in your SCM configuration:

```bash
scm remote add github benjaminabbitt/scm-github
```

Then pull fragments or prompts:

```bash
# Pull a fragment
scm remote pull github/general/tdd

# Pull a prompt
scm remote pull github/code-review --type prompt

# Pull a profile
scm remote pull github/architect --type profile
```

## Structure

```
scm/v1/
├── fragments/    # Context fragments for AI assistants
│   ├── general/  # General development practices
│   ├── lang/     # Language-specific guidance
│   ├── patterns/ # Architecture patterns
│   ├── testing/  # Testing practices
│   └── tools/    # Tool-specific configurations
├── prompts/      # Reusable prompts
└── profiles/     # Curated fragment collections
```

## Available Content

### Fragments

| Category | Fragments |
|----------|-----------|
| General | communication, code-quality, documentation, problem-solving, pushback, security, tdd |
| Languages | golang, python, rust, typescript, pipx, uv |
| Patterns | 12-factor, behavioral-interface-test, container-overlay, cqrs, event-sourcing, prototype, type-discriminated-config |
| Testing | gherkin, test-organization |
| Tools | asdf, ast-grep, bacon, devcontainer, git, just, lsp, rtk, testcontainers |
| MCP | mcp-tasks, scm, sequential-thinking |

### Prompts

- `code-review` - Code review guidance
- `code-review-recent` - Review recent changes
- `distill` - Text compression
- `write-readme` - README generation

### Profiles

- `architect` - Software architecture focus
- `concurrency` - Concurrent programming
- `domain-expert` - Domain-driven design
- `performance` - Performance optimization
- `standards` - Coding standards enforcement

## License

MIT
