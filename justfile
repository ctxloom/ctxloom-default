# ctxloom-default — content bundle publishing helpers.
#
# Signing writes a detached <bundle>.sig using YOUR publisher key from ssh-agent;
# ctxloom never reads or stores private key material. Your key must be loaded in
# ssh-agent and trusted under publish.v1.ctxloom.dev. KEY remains a PARAMETER
# because this project trusts more than one identity and ctxloom deliberately
# refuses to auto-pick — it now defaults to the ctxloom publishing key rather
# than being required, so the common case needs no argument.
#
# KEY accepts an ssh-agent key comment (substring, case-insensitive — e.g.
# "ben+ctxloom@abbitt.me"), a SHA256:... fingerprint, or a path to a .pub key.
#
# THE DEFAULT IS THE CTXLOOM PUBLISHING IDENTITY, and which key signs what is a
# RULE rather than a preference: ctxloom and ctxloom-default are signed with the
# ctxloom identity, personal content with the personal one. KEY stays a
# parameter because this project trusts more than one identity — the default
# just stops the common case depending on whatever `git config user.signingkey`
# happens to answer, which is exactly how the identities drifted apart.

TOP := `git rev-parse --show-toplevel`
SIGN_KEY := "ben+ctxloom@abbitt.me"

# Sign every local bundle this project publishes.
#   just sign                    # the ctxloom publishing key
#   just sign ben@abbitt.me      # override
sign KEY=SIGN_KEY:
    ctxloom bundle sign --all --key {{KEY}}

# Sign a single bundle (or item ref, which resolves to its containing bundle).
#   just sign-bundle acp-setup
sign-bundle REF KEY=SIGN_KEY:
    ctxloom bundle sign {{REF}} --key {{KEY}}
