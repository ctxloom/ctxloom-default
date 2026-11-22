---
source_sha256: a69892dfd5370dbdf97821a380a473492fec96c1d6868e5ad8ecc433b981bc6c
---
# Test Coverage

- Target 90%+ coverage; unit + integration tests exercising the full app
- Acceptable gaps:
  - Main entrypoints (covered by E2E)
  - Generated code
  - Panic/fatal paths that can't occur
  - Default factory functions (exclude via tooling)
