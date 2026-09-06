---
distilled_by: claude-code
---
Use bacon as the continuous checker; version-control project bacon.toml (`bacon --init`). House config: default_job "clippy"; jobs.clippy-all = `cargo clippy --all-targets -- -D warnings` (need_stdout=false); jobs.check-win = `cargo check --target x86_64-pc-windows-gnu`; jobs.check-examples = `cargo check --examples` with watch=["examples"].