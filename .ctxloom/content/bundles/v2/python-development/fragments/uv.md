---
tags:
  - python
  - tooling
  - package-manager
installation: |-
  pipx install uv (recommended)
  Or: curl -LsSf https://astral.sh/uv/install.sh | sh
content_hash: sha256:41adeb170cd05251172665efd1bb5e1d4b86375386e51193b1d28286de886bd9
---
# UV Package Manager

uv is the default for all Python projects. pipx is only for standalone CLI tools; anything project-scoped goes through uv.

- Commit `uv.lock`
- Prefer `uv run` over activating the venv