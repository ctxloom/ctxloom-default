---
distilled_by: claude-code
---
# Lens: Design & Architecture
Do the pieces fit the system, and will future changes stay cheap?
- **Fit**: does this belong in this layer/module/service? Does it respect existing boundaries and dependency direction (no inward leaks)?
- **Cohesion & coupling**: related things together; minimal cross-module knowledge. Watch **connascence** — prefer weak/static forms (name, type) over strong/dynamic (position, meaning, execution order, timing); keep connascent code close; reduce the number of co-dependent sites.
- **Extensibility vs over-engineering**: the hard-to-change-later decisions (schemas, wire formats, public contracts, vendor lock-in) get the most scrutiny; speculative generality (YAGNI) and SOLID weaponized into interface proliferation both get pushed back.
Pair this with the project's language fragment for idiom-specific structural footguns.