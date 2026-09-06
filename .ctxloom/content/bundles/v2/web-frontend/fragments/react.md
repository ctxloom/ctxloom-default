---
tags:
  - react
  - web
  - frontend
content_hash: sha256:5475cb45f73c71756838d6fe3b32f86b58355b40c4e71c91e7ab21ed413d0d91
---
# React (TypeScript)

## Component Structure

```
components/
  Button/
    Button.tsx        # Component
    Button.test.tsx   # Tests co-located
    index.ts          # Re-export
```

## Function Components Only

```typescript
// Named export, explicit return type
export function UserCard({ user }: UserCardProps): React.ReactElement {
  return <div>{user.name}</div>
}

// Props interface above component
interface UserCardProps {
  user: User
  onSelect?: (user: User) => void
}
```