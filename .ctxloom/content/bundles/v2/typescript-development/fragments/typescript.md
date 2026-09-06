---
tags:
  - typescript
  - language
content_hash: sha256:ee7230a293bb423abddddabd4a058b397bfd004c74fb156f519707ccabd7a1d6
---
# TypeScript Dev

## Config
tsconfig strict mode required: strict, noImplicitAny, strictNullChecks, noUncheckedIndexedAccess.

## Naming
- PascalCase: classes/interfaces/types/enums
- camelCase: functions/variables/params
- kebab-case: files (`user-service.ts`)
- Tests: `.test.ts` co-located
- CONSTANT_CASE: true globals only
- Abbrevs as words: `loadHttpUrl`

## Type Safety
- Never: `any`, `@ts-ignore`/`@ts-nocheck`, type assertions (`as`), non-null assertions (`!`)
- Use `unknown` for indeterminate types

## Imports/Exports
- Named exports only — no default exports
- `import type` for type-only imports
- Include `.js` extension for ESM imports

## Classes
- Parameter properties: `constructor(private readonly x: X)`; TS visibility (`private`/`protected`), not `#`