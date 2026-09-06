---
distilled_by: claude-code
---
Vite config: content-hashed output filenames via build.rollupOptions.output (`assets/[name]-[hash].js` for entries/chunks, `assets/[name]-[hash].[ext]` for assets) and dev server header `Cache-Control: no-store`.