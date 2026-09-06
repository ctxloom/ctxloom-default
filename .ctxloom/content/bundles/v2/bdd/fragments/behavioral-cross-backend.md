---
tags:
  - bdd
  - gherkin
  - cross-backend
  - substitutability
content_hash: sha256:5aab191c77e99b732f3224598fedafd354c9c8ffa3aeb606129617af18b56d2f
---
# Behavior Over Implementation: Cross-Backend BDD

Gherkin describes **behavior**, never the **backend** that provides it. When a capability has interchangeable implementations — a store backed by filesystem/S3/GCS, a bus over Kafka/NATS/AMQP, a database on Postgres/SQLite — write **one** behavioral feature set and run it **unchanged against every implementation**. The backend is a *test-harness dimension*, not part of the specification. Passing the same behavioral suite on every implementation is the proof that they are substitutable (Liskov).

## The Rule

A feature or step must not name or assume a backend, nor assert backend mechanics.

```gherkin
# Wrong — backend mechanics leak into the spec
When the payload is written to the S3 bucket
Then a 200 response is returned
And an object exists at key "<hash>"

# Right — behavior only; EVERY backend must satisfy it
When a payload larger than the inline threshold is published
And the message is consumed
Then the consumer receives the original payload unchanged
```

**Litmus test:** if the wording would change when you swap the backend, it describes *how*, not *what* — abstract it to the behavior.

## The Harness Carries the Backend

The feature stays constant; the harness parameterizes over implementations.

```
features/
  payload_offload.feature      # one behavioral spec — no backend named
harness/
  run.rs                       # runs the suite against each backend:
                               #   filesystem, s3 (testcontainer), gcs (emulator)
```

The active backend is wired in `Given` setup via configuration/DI; the steps never know which one is running. Use testcontainers/emulators so the real implementation is exercised — not a mock.

## Anti-Patterns

- Backend names in feature/step text ("...to Redis", "...the SQL row").
- Per-backend feature files that drift apart (duplicated scenarios, subtly different assertions).
- Asserting backend mechanics (HTTP status, object keys, table rows) instead of observable behavior.
- Mocking the backend away — then you've tested the mock, not substitutability.

Unit-level analogue: the **Behavioral Interface Test (BIT)** — one behavioral suite asserted against every implementation of a trait/interface.