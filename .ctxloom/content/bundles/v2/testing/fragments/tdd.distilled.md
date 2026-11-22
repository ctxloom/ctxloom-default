---
source_sha256: 65aaa3bdb2d08d8d31bb076f6fc6b4307d5b1a648ff7ac2c1eb3cc9ce4b6d420
---
# Test-Driven Development (TDD)

Red-green-refactor is mandatory. Verify red test runs and fails for the right reason before implementing.

## Integration/Acceptance Tests

- Build and run actual binaries; don't define hooks
- Mark slow tests with slow tag (framework-specific)
- Ensure test isolation; clean up after yourself

## Test Naming

Format: `test_<action>_<condition>_<expected_result>`

- Python: `test_divide_by_zero_raises_value_error` (snake_case)
- C#/Java: `testDivideByZeroRaisesValueError` (camelCase)
- JavaScript: `testDivideByZeroThrowsError` (camelCase)

Readability over strict format compliance.

## Test Organization

Order by complexity: simple usage-demonstrating tests first (developer examples), comprehensive tests and edge cases last. Tests serve as documentation.
