---
source_sha256: d907b82c8aaa9408713dd6c7a95a5d0a6325f34cfd5eabf3409837280c0f9d6c
---
# Human Review Checklist

AI code: correct happy path, dangerous elsewhere.

## Hallucination Check
- LLMs reference nonexistent packages at 5.2% (commercial) to 21.7% (open-source) rates (Spracklen et al., *We Have a Package for You!*, arXiv:2406.10279, 2024; 16 LLMs, 576k samples). Verify before trusting.
- Verify imports: `npm info`, `pip show`, `cargo search`
- Check API signatures
- Confirm endpoints exist

## Test Integrity (AI "fixes" by)
- Deleting tests
- Removing assertions
- Mocking away behavior
- See `mutation-as-test-validator` for the deterministic check.

## Red Flags
- Deleted code unexplained
- Catch-all replacing specific handlers
- Removed validation
- async/sync changes without reason
- Unjustified new deps

## Reject Immediately
- Security vulns in sensitive code
- Deleted tests w/o justification
- Hallucinated deps
- Race conditions
- Missing error handling in critical paths
