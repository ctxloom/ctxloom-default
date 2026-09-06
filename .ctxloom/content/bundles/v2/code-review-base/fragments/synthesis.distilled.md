---
distilled_by: claude-haiku-4-5-20251001
---
# Code Review — Synthesis

Synthesize multiple specialist reviews into one coherent report.

## Synthesis
- **De-duplicate**: collapse identical issues; note lenses flagging them
- **Resolve conflicts**: surface trade-offs, recommend
- **Rank** by severity (Critical → Major → Minor), confidence
- **Drop noise**: filter low-value/speculative items
- Preserve `file:line` refs, concrete fixes

## Output
1. **Summary**: what changed, assessment, merge recommendation (block / approve-with-changes / approve)
2. **Critical, Major, Minor**: `file:line`, consequence, fix, source lens(es)
3. **Notable strengths** (brief)