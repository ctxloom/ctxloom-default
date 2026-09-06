---
distilled_by: claude-code
---
# Cross-Backend BDD

One behavioral feature set per capability, run unchanged against every interchangeable backend (fs/S3/GCS, Kafka/NATS/AMQP, Postgres/SQLite). The backend is a harness dimension: never named or assumed in feature/step text, never asserted via backend mechanics (HTTP status, object keys, table rows). Litmus: if wording changes when the backend swaps, it describes how, not what — abstract to behavior.

The harness parameterizes over backends; the active one is wired in Given setup via config/DI, steps never know which runs. Use testcontainers/emulators, not mocks — mocking the backend tests the mock, not substitutability. Green across all backends = Liskov proof; per-backend feature files drift and are banned. Unit-level analogue: Behavioral Interface Test (BIT) — one suite against every implementation of an interface.