---
source_sha256: 58e028d35410c6a99e5c7df6978022c33073acb8e000d9cecf0df00103a3e774
---
# Concurrency Warnings

- AI-authored code: ~2x more likely than human-only code to have concurrency and dependency-correctness mistakes (CodeRabbit, *State of AI vs Human Code Generation*, 2025; 470 PRs; ~1.7x more issues overall, concurrency a leading subcategory).
- Don't "optimize" sequential awaits into parallel ones; ordering may be load-bearing.
- Mark intentional ordering with `// SYNC-REQUIRED: [reason]`:

```javascript
// SYNC-REQUIRED: email needs user.id from save
await saveUser(user);
await sendEmail(user);

// AI BUG: await Promise.all([saveUser, sendEmail])
```
