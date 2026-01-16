#!/bin/bash
# =============================================================================
# generate-number.sh - Generate random numbers
# =============================================================================
# Usage:
#   ./generate-number.sh [amount] [range] [include_negative]
#
# Arguments:
#   amount            - Number of random numbers to generate (default: 1)
#   range             - Maximum value (0 to range) (default: 100)
#   include_negative  - Include negative numbers (true/false) (default: false)
#
# Examples:
#   ./generate-number.sh              # Generate 1 number (0-100)
#   ./generate-number.sh 5            # Generate 5 numbers (0-100)
#   ./generate-number.sh 3 1000       # Generate 3 numbers (0-1000)
#   ./generate-number.sh 5 50 true    # Generate 5 numbers (-50 to 50)
# =============================================================================

set -euo pipefail

ARG_AMOUNT="${1:-1}"
ARG_RANGE="${2:-100}"
ARG_INCLUDE_NEGATIVE="${3:-false}"

generate_number() {
    local amount="${1:-1}"
    local range="${2:-100}"
    local include_negative="${3:-false}"
    
    for ((i=0; i<amount; i++)); do
        if [[ "${include_negative,,}" == "true" ]]; then
            # Generate number from -range to +range
            local num=$((RANDOM % (range * 2 + 1) - range))
        else
            # Generate number from 0 to range
            local num=$((RANDOM % (range + 1)))
        fi
        echo "$num"
    done
}

generate_number "$ARG_AMOUNT" "$ARG_RANGE" "$ARG_INCLUDE_NEGATIVE"
