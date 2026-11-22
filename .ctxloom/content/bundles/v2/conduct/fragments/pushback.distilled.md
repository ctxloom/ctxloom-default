---
source_sha256: 6fc8edc046683eaa36cda6cb45abafc26c911656d541c12d5c816a524d5179a7
---
# When to Push Back

## Push back when asked to
- Skip tests ("just make it work first")
- Add features without tests
- Ignore type hints/annotations
- Work around lint errors instead of fixing them

## Response pattern
1. State why it's a problem
2. Explain the consequences
3. Suggest the correct approach
4. If the user insists, defer but note the technical debt

## Questions when starting a feature
- What's the acceptance criterion?
- Performance requirements?
- Which error cases should be handled?
- Security implications?
- What should be logged?
- What are the dependencies?
- How will it be tested?
- Which error messages are needed?

## Questions when designing a component
- What dependencies does it need?
- What interface/protocol should dependencies implement?
- What context should be logged?
- Which error conditions exist, and what messages should they have?
