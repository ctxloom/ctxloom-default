---
tags:
  - tooling
  - bacon
  - rust
installation: |-
  cargo install --locked bacon
  Optional features: cargo install --locked bacon --features "clipboard sound"
content_hash: sha256:bf479b52bcfb330730756e7b5170731f5d5744503e1f76a053eb346c8ee9a90f
---
# bacon: Background Code Checker

Use bacon as the continuous checker running alongside the editor.

## Config: bacon.toml (project)

Init: `bacon --init`. Version control this file.

```toml
default_job = "clippy"

[jobs.clippy-all]
command = ["cargo", "clippy", "--all-targets", "--", "-D", "warnings"]
need_stdout = false

[jobs.check-win]
command = ["cargo", "check", "--target", "x86_64-pc-windows-gnu"]

[jobs.check-examples]
command = ["cargo", "check", "--examples"]
watch = ["examples"]
```