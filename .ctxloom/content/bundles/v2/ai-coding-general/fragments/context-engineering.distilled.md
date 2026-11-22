---
source_sha256: eb7292337e9a411ddcbbf5cb5606835687cc0126c3770f6ee5ff4196e404c9f4
---
# CLAUDE.md Rules

- **Size:** 100-200 lines max. Move overflow to per-folder CLAUDE.md files.
- **Must include:**
  - Tech Stack: language, framework, database, testing tools with versions
  - Architecture: directory structure, purpose of each folder
  - Commands: build, test, lint, deploy
  - Coding Rules: project-specific conventions AI would otherwise violate
- **Do NOT include:**
  - General language syntax
  - Patterns already enforced by linters
  - Things Claude does correctly without instruction
- **Test:** Would Claude make a mistake without this line? If no, delete it.
- **Maintenance:** When Claude makes a mistake, add the correction to CLAUDE.md immediately.
