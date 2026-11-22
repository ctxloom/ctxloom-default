---
source_sha256: 4d87419ed423c2b08eb2d927c30d502b9de0b1f3ffe934ca865d22cc16cc9607
---
# Code Quality Standards

## Before Writing Code
- **Research first**: search the codebase for existing implementations before writing new code; read existing patterns, conventions, utilities
- **No duplication**: reuse existing functions, types, modules
- **Extend, don't recreate**: extend or refactor similar functionality instead of writing parallel implementations

## Code Size
- Files under 500 lines; exceed only when necessary (very high coupling and cohesion)
- Small functions, each doing one thing well
- Optimize for reading and understanding, not performance
- Separate interfaces and implementations into different files

## Naming
- Interfaces/protocols (py) are the thing: `UserService` is a Protocol. No `IWhatever`
- Implementations named after *how* the interface is implemented. Single: `DefaultUserService`. Multiple: `HttpUserService`, `CachedUserService`

## Clean Up
- Kill background processes when no longer needed
- Remove unused code, files, imports, variables; leave no dead code

## Comments
- No change-tracking comments ("changed X to Y", "removed Z", "updated for feature W"); git tracks history
- No revision history in code: don't record what was modified, when, or by whom
- No commented-out code; delete it (git has it)
- Comments explain *why*, not *what* or *what changed*
