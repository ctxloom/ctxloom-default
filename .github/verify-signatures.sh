#!/usr/bin/env bash
# Verify every bundle in this repo carries a valid publisher signature made by
# the expected key. Runnable locally (./.github/verify-signatures.sh) as well as
# in CI, because the failure this guards against is committed, not built: a
# bundle edited without re-signing looks completely fine until a CONSUMER
# advances its pin, at which point ctxloom WITHHOLDS the bundle and any profile
# inheriting from it silently degrades.
#
# A bundle is a tree: SHA256SUMS lists a digest for every file in it, and
# .sigs/ holds the detached signature over that manifest. Verifying one is
# three checks — the manifest's signature verifies, every listed file matches
# its digest, and no file in the tree is left unlisted (an unlisted file is
# covered by nothing).
#
# Uses ssh-keygen -Y verify — the standard OpenSSH signature-verification path,
# the same one ctxloom itself validates against — rather than reimplementing
# SSHSIG parsing. -I pins the expected principal, so a signature by the wrong
# key fails here too.
set -euo pipefail

IDENTITY="${SIGN_IDENTITY:-ben+ctxloom@abbitt.me}"
NAMESPACE="publish.v1.ctxloom.dev"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ALLOWED="$REPO_ROOT/.github/allowed_signers"
BUNDLES="$REPO_ROOT/.ctxloom/content/bundles/v2"

[[ -f "$ALLOWED" ]] || { echo "FATAL: no allowed_signers at $ALLOWED"; exit 1; }
[[ -d "$BUNDLES"  ]] || { echo "FATAL: no bundle directory at $BUNDLES"; exit 1; }

mapfile -t trees < <(find "$BUNDLES" -mindepth 2 -maxdepth 2 -name bundle.yaml -type f -printf '%h\n' | sort)

# An empty sweep must FAIL, never pass quietly. A check that verifies nothing
# and exits 0 is indistinguishable from a check that verified everything, and
# that is the more dangerous of the two.
if (( ${#trees[@]} == 0 )); then
  echo "FATAL: found no bundles under $BUNDLES — refusing to report success"
  exit 1
fi

fail=0
for tree in "${trees[@]}"; do
  rel="${tree#"$REPO_ROOT"/}"
  manifest="$tree/SHA256SUMS"
  sigs=("$tree"/.sigs/SHA256SUMS."$NAMESPACE".*.sig)

  if [[ ! -f "$manifest" || ! -f "${sigs[0]}" ]]; then
    echo "UNSIGNED   $rel"
    fail=1
    continue
  fi

  if ! out=$(ssh-keygen -Y verify -f "$ALLOWED" -I "$IDENTITY" \
               -n "$NAMESPACE" -s "${sigs[0]}" < "$manifest" 2>&1); then
    echo "BAD SIG    $rel"
    echo "           $out"
    fail=1
    continue
  fi

  if ! out=$(cd "$tree" && sha256sum --quiet --strict -c SHA256SUMS 2>&1); then
    echo "TAMPERED   $rel"
    echo "$out" | sed 's/^/           /'
    fail=1
    continue
  fi

  extras=$(comm -13 \
    <(sed -e '/^#/d' -e '/^$/d' -e 's/^[0-9a-f]\{64\}  //' "$manifest" | sort) \
    <(cd "$tree" && find . -type f ! -name SHA256SUMS ! -path './.sigs/*' | sed 's#^\./##' | sort))
  if [[ -n "$extras" ]]; then
    echo "UNCOVERED  $rel"
    echo "$extras" | sed 's/^/           /'
    fail=1
    continue
  fi

  echo "ok         $rel"
done

echo
if (( fail )); then
  echo "FAILED: every bundle must be signed by $IDENTITY."
  echo "Fix with: ctxloom bundle sign <name> --key $IDENTITY   (then commit the whole tree)"
  exit 1
fi
echo "All ${#trees[@]} bundle(s) signed by $IDENTITY."
