# ctxloom-default — content bundle publishing helpers.
#
# Signing writes a detached <bundle>.sig using YOUR publisher key from ssh-agent;
# ctxloom never reads or stores private key material. Your key must be loaded in
# ssh-agent and trusted under publish.v1.ctxloom.dev. KEY is required because this
# project trusts more than one identity, so ctxloom can't auto-pick one.
#
# KEY accepts an ssh-agent key comment (substring, case-insensitive — e.g.
# "ben@abbitt.me"), a SHA256:... fingerprint, or a path to a .pub key.

TOP := `git rev-parse --show-toplevel`

# Sign every local bundle this project publishes.
#   just sign ben@abbitt.me
sign KEY:
    ctxloom sign --all --key {{KEY}}

# Sign a single bundle (or item ref, which resolves to its containing bundle).
#   just sign-bundle acp-setup ben@abbitt.me
sign-bundle REF KEY:
    ctxloom sign {{REF}} --key {{KEY}}
