---
tags:
  - vite
  - build
  - web
content_hash: sha256:c7542832e1f313594b076ecf41cc1dfb5defb45ce1aabf7d83991f8a21c83118
---
# Vite

## Config (vite.config.ts)

```typescript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  build: {
    rollupOptions: {
      output: {
        // Content-hashed filenames for caching
        entryFileNames: 'assets/[name]-[hash].js',
        chunkFileNames: 'assets/[name]-[hash].js',
        assetFileNames: 'assets/[name]-[hash].[ext]',
      },
    },
  },
  server: {
    // Disable caching in dev
    headers: { 'Cache-Control': 'no-store' },
  },
})
```