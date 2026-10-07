---
name: ctxloom-doctor
description: Diagnose a ctxloom setup by running `ctxloom doctor`, which only reports, then fix or explain each finding. Use when the user asks to "check my ctxloom setup", "run doctor", "why isn't ctxloom working", "is ctxloom set up right", after `ctxloom init` or an upgrade, or before relying on isolation or delegated agents.
---

# ctxloom-doctor

`ctxloom doctor` is the authority. It runs every check, and each row names its
own problem and, where one is known, its own fix. Doctor changes nothing: every
fix it names is still undone when it exits. This skill does not restate the
checks. Its job is to run the command, read what comes back, and act on it
with judgment.

## 1. Run it

    ctxloom doctor --format json

Use JSON so you read fields, not wrapped text. Each check carries a `marker`,
a `status`, a `detail`, and sometimes a `remedy`. Run `ctxloom doctor --deps`
instead when the project has not been set up yet. It limits the report to
machine capabilities, so a fresh checkout does not read as a wall of failures.

The exit code tells you nothing. Doctor never fails on a finding, so read
the report.

## 2. Read each row by status

- **ok** means the subject is in the intended state. Do not mention it unless
  asked.
- **info** is context, not a verdict, and there is nothing to fix. Relay it
  only when it answers the user's question.
- **warn** is doctor's only failure signal. Work through every one.

For each warn, the fix is the `remedy` field when present, otherwise the
command or action named inside `detail`. Quote the marker when you report a
row, so the user can find it in their own run.

A warn can be transient. A runner container whose owner died is listed with a
command that force-removes it, but a healthy runner waits out an owner-loss
window to be re-adopted, then exits on its own and takes its container with
it. Only one still listed after that window is wedged. Re-run doctor a few
minutes later before treating the row as real. A wedged runner is a defect
worth reporting upstream.

## 3. Act by class

Fix it yourself, then re-run doctor to confirm, when the remedy is a ctxloom
command that only writes this project's own setup. Examples are installing
hooks or gitignore rules, or re-running a setup phase.

Stop and ask the human before acting when the remedy:

- **extends trust**. Adding a remote with `ctxloom remote create` is the user
  vouching for that git repository: content resolves only through a
  registered remote, and what it serves reaches their assistant. Present the
  repository and why it would be added. Never add one on their behalf.
- **touches identity**: changing git identity (`user.name`, `user.email`).
  The user chooses which identity their agents commit as.
- **removes anything**, such as a worktree, a branch, files, a container, or
  images. That includes things ctxloom created. Doctor names these and
  deliberately removes none of them, so neither should you without a yes.
  For a runner container, also say whether it has outlived the owner-loss
  window (see section 2). Removing one that has not kills a healthy runner.
- **needs root or changes the host**: sysctl, package installs, or starting a
  container runtime.
- **installs a missing binary**. Name the binary and why doctor wants it. How
  to install it is the user's call.

If a row's detail does not make the cause clear, say so plainly. Do not guess
at a fix.

## 4. What doctor cannot tell you

- **Version currency.** Doctor reports the running version as info and leaves
  the comparison to you. List ctxloom's release tags
  (`git ls-remote --tags https://github.com/ctxloom/ctxloom`), compare them
  to the version doctor printed, and suggest an upgrade only if a newer
  release exists. If the network is unavailable, say the check was skipped.
- **Whether the engine read its context.** Doctor can confirm ctxloom WROTE
  the assembled context onto the engine's surface, never that the engine read
  it. If the user reports the model ignoring its context and doctor is clean,
  say that this is the gap, rather than declaring the setup healthy.

## 5. Report

Lead with the verdict: healthy, healthy with warnings fixed, or needs the
user. Then give one line per warn: the marker, what was wrong, and what you
did or what you need from the user. Finish by re-running doctor if you
changed anything, and report what the re-run shows.
