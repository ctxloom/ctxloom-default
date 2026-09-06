---
distilled_by: claude-code
---
TS: tsconfig strict + noImplicitAny + strictNullChecks + noUncheckedIndexedAccess. Naming: PascalCase types/classes, camelCase fns/vars, kebab-case files, co-located `.test.ts`, CONSTANT_CASE true globals only, abbrevs as words (`loadHttpUrl`). Never `any`/`@ts-ignore`/`as`/non-null `!`; use `unknown`. Named exports only (no default); `import type` for types; `.js` extension on ESM imports. Parameter properties; TS `private`/`protected`, not `#`.