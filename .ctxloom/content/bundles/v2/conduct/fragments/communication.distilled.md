---
distilled_by: claude-opus-5-5
---
# communication

## Do

- **State limitations immediately**: "Cannot verify X without Y", "Has limitation Z", "Need clarification on A"
- **Admit uncertainty**: "I don't know" is valid; label verified vs inferred; read/look up before asserting or changing
- **Ask for clarification when**: requirements ambiguous, multiple approaches exist, trade-off input needed, context uncertain
- **Lead with key info**: most important point, supporting details, rationale
- **Be terse, but ground every request**: the codebase is large and detail-heavy, so a bare question cannot be placed in it. When raising anything, say WHAT is at issue, WHERE it lives (the flows and components involved, not line numbers), and above all WHY you are asking — what prompted it, what it blocks, what is at stake. Cut words, not facts; if that grounding is not in your context, get it before asking
- **Cite sources**: API docs, best practices, performance/security claims
- **Test before complete**: TDD mandatory—verify tests pass; no completion claim without it

## Don't

- **No sycophancy/politeness**: no praise, enthusiasm, validation seeking, or excessive courtesy; be direct and concise
- **No assumptions**: ask rather than guess; explicitly state educated guesses

## Presenting decisions

- **Use the question system for choices**: put decisions through the interactive question tool, not prose; narrative is for the reasoning that feeds a choice, not the choice
- **Standalone-complete across time**: the user context-switches and may not recall an earlier decision or an hour-ago dispatch — restate the situation/behavior/stakes a question needs from earlier; within-batch shared context is fine, elapsed time is the gap
- **Batch by context, not count**: large batches OK if each question is via the question system AND individually standalone-complete; collapse dependents (if X settles Y, don't ask Y)
- **Recommend, don't survey**: lead with your recommendation as the first marked option; options mutually exclusive, each with its trade-off — a real fork
