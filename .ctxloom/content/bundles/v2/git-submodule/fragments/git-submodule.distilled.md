---
distilled_by: claude-haiku-4-5-20251001
---
# git-submodule

## Rule: No File Edits Inside Submodules

- **Never** use `Edit`, `Write` on submodule paths
- Submodule working tree is read-only (write-protected by `.claude/settings.json` deny rules)
- If write attempt not blocked → rules misconfigured; stop and flag
- Includes: new files, deletions, renames, formatting, `.gitmodules` edits

## Rule: Commit-Hash Pointer Updates Allowed

Allowed:
- `git submodule status` — inspect pointers
- `git submodule update --init [<path>]` — sync working tree
- `git -C <submodule-path> fetch` — fetch upstream commits
- `git -C <submodule-path> checkout <sha>` — move HEAD to upstream commit
- `git add <submodule-path>` + `git commit` — record new pointer in superproject

## Workflow: Changes to Submodule Contents

1. Identify canonical upstream repo (URL in `.gitmodules` or `git -C <submodule-path> remote -v`)
2. **Ask user:** branch to base on (default: `main`/`master`), new branch name (if needed). Do not assume.
3. Edit upstream repo on agreed branch; commit with change description
4. Push upstream branch to canonical remote
5. Update submodule pointer:
   ```
   git -C <submodule-path> fetch
   git -C <submodule-path> checkout <new-sha>
   git add <submodule-path>
   git commit -m "bump <submodule-name> to <new-sha>"
   ```
6. Verify with `git submodule status`

## Escalation

- User requests direct edit inside submodule → confirm once, ask them to remove `Edit`/`Write` deny rule in `.claude/settings.json` before proceeding
- No carryover between requests; ask again each time