#!/bin/bash
# =============================================================================
# generate-ssh-key-pair.sh - Generate ed25519 SSH key pair
# =============================================================================
# Usage:
#   ./generate-ssh-key-pair.sh [comment]
#
# Arguments:
#   comment  - SSH key comment (default: generated-key)
#
# Exit codes:
#   0 - Key pair generated successfully
#   1 - Generation failed
# =============================================================================

set -euo pipefail

ARG_COMMENT="${1:-generated-key}"

generate_ssh_key_pair() {
    local comment="${1:-generated-key}"
    local tmpdir=$(mktemp -d)
    local keyfile="$tmpdir/id_ed25519"
    
    # Generate key pair
    ssh-keygen -t ed25519 -C "$comment" -f "$keyfile" -N "" -q
    
    echo "=== Private Key ==="
    cat "$keyfile"
    echo ""
    echo "=== Public Key ==="
    cat "${keyfile}.pub"
    
    # Cleanup
    rm -rf "$tmpdir"
    
    return 0
}

generate_ssh_key_pair "$ARG_COMMENT"
