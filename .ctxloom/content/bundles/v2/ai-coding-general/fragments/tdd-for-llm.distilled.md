---
source_sha256: 2187a0f6d5ece99942239ea678cfa346db6211169807c744e27f2f0d9f5822fc
---
# TDD for LLM-Written Code

- LLMs are non-deterministic generators; tests are the deterministic gate around them.

## Rule
- Demand TDD from the LLM: tests first, implementation second. Non-negotiable.

## Workflow
1. Describe the requirement.
2. LLM writes tests against the requirement (not the implementation).
3. Review tests: do they capture the requirement, edge cases, and failure modes?
4. LLM implements to make the tests pass.
5. Run tests.

## Why
- The test suite is the contract; generated code is checked against it.
- Without tests-first, the model fills the contract with whatever it produced, and there is no separate ground truth.

## Anti-Patterns
- LLM writes the implementation, then tests against it. Tests confirm the bug, not the requirement.
- Vacuous assertions: `assert!(true)` next to a function call passes without verifying anything.
- Implementation-coupled tests: `assert_eq!(hash("x"), 0x7a3f...)` is brittle to refactoring and blind to behavior.
- Skipping step 3. Test review is the load-bearing review; implementation review is downstream.

## What Tests Document
- Document the **problem**, not the solution.
- A good test names the requirement in its name, sets up inputs, runs the function, and asserts observable behavior.

## Verification
```
Show me the tests before the implementation. I will review the tests, approve them, then you write the implementation.
```
