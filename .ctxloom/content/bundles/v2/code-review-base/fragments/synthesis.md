---
tags:
  - review
  - synthesis
content_hash: sha256:f1d8db4a02633858b70880d0dbf83dc97557253a52b01f1477a8cb976fc22c11
---
# Code Review — Synthesis

You are given several independent specialist code reviews of the same
change (each from a different lens: correctness, security, performance,
etc.), plus possibly externally-provided notes. Combine them into ONE
coherent report.

## How to synthesize
- **De-duplicate**: collapse the same issue raised by multiple lenses into a
  single finding (note the lenses that flagged it — agreement raises
  confidence).
- **Resolve conflicts**: if lenses disagree (e.g. performance vs
  readability), surface the trade-off and give a recommendation.
- **Rank** by severity (Critical → Major → Minor), then by confidence.
- **Drop noise**: low-value or speculative items; say if a lens found
  nothing material.
- Preserve `file:line` references and concrete fixes.

## Output
1. **Summary** — what the change does; overall assessment; merge
   recommendation (block / approve-with-changes / approve).
2. **Critical**, **Major**, **Minor** sections — each finding with
   `file:line`, the consequence, the fix, and which lens(es) raised it.
3. **Notable strengths** (brief).