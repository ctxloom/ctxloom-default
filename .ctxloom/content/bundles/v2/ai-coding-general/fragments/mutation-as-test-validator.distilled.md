---
source_sha256: f4a4aa571762f726c51499407683f14a73a460e718b32020dc17f56e722854e4
---
# Mutation Testing as Test Validator

Passing tests don't prove tests are good; mutation testing is the deterministic check.

- LLMs produce plausible tests at scale; plausible ≠ meaningful.
- Mutation testing catches:
  - Tautological assertions (`assert_eq!(result, calculate(5, 3))` always passes)
  - Missing boundary edge cases
  - Implementation-coupled tests: brittle to refactor, blind to real bugs

## Workflow

After TDD round-trip:
1. LLM writes tests
2. Human reviews tests
3. LLM implements
4. **Run mutation testing**
5. Analyze survivors: which behaviors are untested?
6. Add tests that kill survivors, or accept the gap explicitly

## Tools

- Rust: `cargo-mutants`
- Java: `pitest`
- Python: `mutmut`, `cosmic-ray`
- JS/TS: `stryker`
- Go: `gomutation`, `go-mutesting`

## Target Kill Rates

- Pure utility functions: 80–90%+
- Business logic: 80–90%
- Framework glue delegating to tested core: 60–70%
- Logging-only paths: survivors acceptable

Teams with 80–90% code coverage often find 30% mutation kill rates on first adoption. Coverage measures execution; mutation testing measures verification.

## Anti-Patterns

- Treating high code coverage as test quality.
- Killing a surviving mutant with `assert!(true)` next to the line: score rises, signal goes to zero.
