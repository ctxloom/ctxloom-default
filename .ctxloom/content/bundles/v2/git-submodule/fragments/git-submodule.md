---
tags:
  - git
  - submodule
  - permissions
installation: |-
  This bundle's policy is enforced by the harness, not by prompt guidance alone. Add the following to `.claude/settings.json` so Claude is explicitly denied edit/write access inside every submodule path:

  ```json
  {
    "permissions": {
      "deny": [
        "Edit(<submodule-path>/**)",
        "Write(<submodule-path>/**)",
        "Edit(.gitmodules)",
        "Write(.gitmodules)"
      ],
      "allow": [
        "Bash(git submodule status)",
        "Bash(git submodule status *)",
        "Bash(git submodule update --init)",
        "Bash(git submodule update --init *)",
        "Bash(git -C * fetch)",
        "Bash(git -C * fetch *)",
        "Bash(git -C * checkout *)",
        "Bash(git add *)",
        "Bash(git commit *)"
      ]
    }
  }
  ```

  For each path returned by `git submodule status`, add one `Edit(<path>/**)` and one `Write(<path>/**)` entry to `deny`. The deny rules are the point of this bundle — do **not** skip them.

  The `allow` entries exist so Claude can still update the superproject's commit-hash pointer for a submodule (fetch in the submodule, check out the target SHA, `git add <submodule-path>` in the superproject, commit). They do not permit editing files inside the submodule — the `deny` rules take precedence.

  To perform a one-time approved write inside a submodule, temporarily remove the relevant `Edit`/`Write` deny entry, do the work, then restore the rule in the same session. Do not leave deny rules disabled between sessions.
content_hash: sha256:6c7c6906419515a69965d1ff3ac371e028f24d481a3586f9f5251eda2c5b4d1d
---
# Git Submodule Policy

## Rule: No File Edits Inside Submodules

- **Never** use `Edit`, `Write`, or any file-modifying tool on a path inside a git submodule
- Submodules are write-protected by harness policy (see `.claude/settings.json` deny rules); if a write attempt is not blocked, the rules are misconfigured — stop and flag it rather than proceeding
- Treat a submodule's working tree as read-only reference material, even if it appears writable
- Applies to every form of content change: new files, deletions, renames, formatting, `.gitmodules` edits

## Rule: Commit-Hash Pointer Updates Are Allowed

Updating the superproject's reference to a submodule commit is permitted. This is a pointer change in the superproject, not a content change inside the submodule.

Allowed operations:
- `git submodule status` — inspect current pointers
- `git submodule update --init [<path>]` — sync working tree to the recorded pointer
- `git -C <submodule-path> fetch` — fetch new commits from the submodule's upstream
- `git -C <submodule-path> checkout <sha>` — move the submodule HEAD to an existing upstream commit
- `git add <submodule-path>` + `git commit` in the superproject — record the new pointer

## Workflow: Changes That Require Editing a Submodule's Contents

When a task needs changes to code that lives inside a submodule, route the change through the canonical upstream repository. **Do not edit files inside the submodule's checkout in this project.**

1. **Identify the canonical location.** Find the submodule's upstream repository (the URL in `.gitmodules` or `git -C <submodule-path> remote -v`).
2. **Ask about branching.** Before editing upstream, ask the user:
   - Which branch to base the change on (default: `main`/`master`)
   - Whether to create a new branch, and if so, what to name it
   - Do not assume — branch choice affects review flow and release tracking
3. **Make the change in the upstream repo**, on the agreed branch. Commit there with a normal message describing the code change.
4. **Push the upstream branch** to the canonical remote.
5. **Update the submodule pointer in this project:**
   ```
   git -C <submodule-path> fetch
   git -C <submodule-path> checkout <new-sha>
   git add <submodule-path>
   git commit -m "bump <submodule-name> to <new-sha>"
   ```
6. **Verify** with `git submodule status` that the pointer matches the pushed upstream commit.

## Why

- A file edit inside a submodule's checkout is a detached-HEAD change in a nested repo; it is easy to lose, easy to miss in review, and bypasses the upstream repo's CI and review process
- Pointer updates are high-blast-radius but inspectable in a single diff line; content edits buried inside a submodule are not
- Unexpected state inside a submodule is often someone else's in-progress work — investigate before touching it

## Escalation

- If the user explicitly requests a direct edit inside a submodule, confirm once, then ask them to remove the relevant `Edit`/`Write` deny rule in `.claude/settings.json` before you proceed
- A single prior approval does not carry forward to later requests; ask again each time