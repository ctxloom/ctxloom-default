---
tags:
  - review
  - structural
  - architecture
  - design
notes: |-
  The lens for whether code FITS the system rather than whether it
  works. Structural defects — wrong layer, leaked dependency
  direction, premature abstraction — are the cheapest to catch at
  review and the dearest to unwind later, because everything built
  afterwards leans on the misplacement. Connascence is named to give
  reviewers a graded vocabulary for coupling strength instead of
  "feels tangled", and the third bullet holds its tension
  deliberately: hard-to-change-later commitments deserve the most
  scrutiny, but so does speculative generality — the lens pushes
  back in both directions. For consumers: every code-review-* lens
  bundle names its fragment `general`, so a bare fragment ask is
  ambiguous across the family; address this one by qualified
  reference (code-review-structural#fragments/general). Origin:
  distilled review practice; no incident behind it.
content_hash: sha256:bc8f16d3cc76cf63210702319913e078a8d4bcbee0f0881ae4f69e2e51a97c64
---
# Lens: Design & Architecture

Do the pieces fit the system, and will future changes stay cheap?

- **Fit**: does this belong in this layer/module/service? Does it respect
  existing boundaries and dependency direction (no inward leaks)?
- **Cohesion & coupling**: related things together; minimal cross-module
  knowledge. Watch **connascence** — prefer weak/static forms (name, type)
  over strong/dynamic (position, meaning, execution order, timing); keep
  connascent code close; reduce the number of co-dependent sites.
- **Extensibility vs over-engineering**: the hard-to-change-later decisions
  (schemas, wire formats, public contracts, vendor lock-in) get the most
  scrutiny; speculative generality (YAGNI) and SOLID weaponized into interface
  proliferation both get pushed back.

Pair this with the project's language fragment for idiom-specific structural
footguns.