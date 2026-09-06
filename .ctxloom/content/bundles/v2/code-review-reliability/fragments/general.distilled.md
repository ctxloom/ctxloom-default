---
distilled_by: claude-code
---
# Lens: Reliability, Errors & Concurrency
Does it fail safely and stay correct under failure and concurrency?
- **Fault tolerance**: timeouts on all I/O; retries with backoff+jitter, idempotency, and a **retry budget / token bucket** — coordinate retry policy across layers to avoid retry storms; circuit breakers/fallbacks (mind their modal behavior, often better at the platform/mesh layer); degrade rather than crash.
(True races need a race detector / runtime confirmation — flag candidates.)