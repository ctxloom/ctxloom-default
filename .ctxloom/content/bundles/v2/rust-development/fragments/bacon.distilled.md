---
source_sha256: 6b32c476918af0e6e965730f9fae6cc9aa3975844e19eda5510e53fdc0d6dd29
---
# bacon: background code checker

Run bacon alongside the editor as the continuous checker.

## Config: bacon.toml (project)

- Init: `bacon --init`. Version-control the file.

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
