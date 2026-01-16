#!/bin/bash
# =============================================================================
# generate-uuid.sh - Generate random UUIDs
# =============================================================================
# Usage:
#   ./generate-uuid.sh [amount]
#
# Arguments:
#   amount  - Number of UUIDs to generate (default: 1)
#
# Examples:
#   ./generate-uuid.sh       # Generate 1 UUID
#   ./generate-uuid.sh 5     # Generate 5 UUIDs
# =============================================================================

set -euo pipefail

ARG_AMOUNT="${1:-1}"

generate_uuid() {
    local amount="${1:-1}"
    
    for ((i=0; i<amount; i++)); do
        if command -v uuidgen &> /dev/null; then
            # Use uuidgen if available
            uuidgen | tr '[:upper:]' '[:lower:]'
        else
            # Fallback: generate UUID v4 manually
            # Corresponds to RFC 4122 UUID v4:
            # https://datatracker.ietf.org/doc/html/rfc4122
            local N1=$((RANDOM))
            local N2=$((RANDOM))
            local N3=$((RANDOM))
            local N4=$((RANDOM))
            printf '%04x%04x-%04x-%04x-%04x-%04x%04x%04x\n' \
                $((N1 & 0xFFFF)) \
                $((N2 & 0xFFFF)) \
                $((N3 & 0xFFFF)) \
                $(((N4 & 0x0FFF) | 0x4000)) \
                $(((RANDOM & 0x3FFF) | 0x8000)) \
                $((RANDOM & 0xFFFF)) \
                $((RANDOM & 0xFFFF)) \
                $((RANDOM & 0xFFFF))
        fi
    done
}

generate_uuid "$ARG_AMOUNT"
