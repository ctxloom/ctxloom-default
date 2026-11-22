---
source_sha256: 7f3a59008ff673447c2646583a350a19eaeeae68fdbadf9e5489566e2e74a74b
---
# Mutation Testing
Validate test quality: verify tests catch code mutations. High coverage + low mutation kill rate = false confidence.

## Workflow
```bash
git worktree add --detach ../.mutants-worktree HEAD
cargo mutants -d ../.mutants-worktree --in-place --timeout 120 -f <file> -- --lib
git worktree remove ../.mutants-worktree --force
```
- Why worktree: shares .git (~300MB), copies only source (~10MB). `--in-place` is safe because the worktree is disposable.

## Target Kill Rates
- Pure utilities, validators: 90%+
- Business logic, state machines: 85%+
- Orchestration, coordinators: 70%+
- Framework glue, adapters: 50%+

## Skip
- Generated code (`*.pb.rs`, `src/proto/`)
- Trivial delegation
- Framework boilerplate
