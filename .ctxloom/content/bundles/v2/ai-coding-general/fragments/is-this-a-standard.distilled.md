---
source_sha256: fe7c82a65b462a9be3cef9d57dc0b005691e6dffe3509dc03775599323fa340c
---
# Is This a Standard?

Before writing infrastructure, ask:

> Is this a standard?

If yes, ask:

> Did we already wire it in?

## Why

- LLMs default to local construction. They've seen many "service that lists what a server does" examples and can produce another.
- They've also seen `grpc.reflection.v1.ServerReflection` many times, but the prompt concerns your problem, not the standard.
- The model writes what it can produce end-to-end over what it would have to look up.

## Commonly Reinvented Categories

- gRPC server reflection → `grpc.reflection.v1.ServerReflection`
- OpenTelemetry instrumentation → OTLP exporters, not custom telemetry
- JWT validation → vetted library, not hand-rolled
- OAuth 2.0 Device Authorization Grant → library
- JSON Schema validation → metaschema
- Kubernetes AdmissionReview → standard webhook shape
- Conventional Commits parsing → existing parser
- Healthchecks → `grpc.health.v1.Health`

## When AI Proposes Writing Infrastructure

1. Name the category ("this sounds like server discovery")
2. Ask whether a standard exists for it
3. If yes, ask whether the project already wires it in
4. Use the standard

## Load-Bearing Comments

At the registration site of a standard mechanism, leave a comment naming the invariant:

```go
// reflection.Register: the canonical "what does this server speak"
// mechanism. Do not add a parallel descriptor service; ask reflection.
reflection.Register(grpcServer)
```

These comments sit next to the call that triggers the temptation to reinvent. They don't depend on the AI consulting an external document.
