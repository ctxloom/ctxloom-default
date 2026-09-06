---
distilled_by: claude-code
---
# Code Quality

Before writing: search the codebase for existing implementations; reuse or extend rather than duplicate or recreate.

Size: <500 lines per file (exceed only with very high coupling/cohesion); small single-purpose functions; optimize for reading, not performance; separate interfaces from implementations by file.

Naming: the interface is the thing — UserService is the Protocol, never IWhatever; implementations are named for how they implement: DefaultUserService (single), HttpUserService/CachedUserService (multiple).

Clean up: kill background processes when done; remove unused code, files, imports, variables; no dead code.

Comments explain why only. No change-tracking comments, no revision history in code, no commented-out code — git has it.