#!/bin/bash
# =============================================================================
# generate-password.sh - Generate random passwords
# =============================================================================
# Usage:
#   ./generate-password.sh [length]    Generate random password
#
# Arguments:
#   length  - Password length (default: 32)
# =============================================================================

set -euo pipefail

ARG_LENGTH="${1:-}"

generate_password() {
    local length="${1:-32}"
    
    # Characters: uppercase, lowercase, digits, symbols
    local chars='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?'
    
    # Generate password ensuring at least one of each type
    local password=""
    
    # Ensure at least one of each type
    password+="${chars:$((RANDOM % 26)):1}"           # Uppercase
    password+="${chars:$((26 + RANDOM % 26)):1}"      # Lowercase
    password+="${chars:$((52 + RANDOM % 10)):1}"      # Digit
    password+="${chars:$((62 + RANDOM % 26)):1}"      # Symbol
    
    # Fill remaining with random chars
    for ((i=4; i<length; i++)); do
        password+="${chars:$((RANDOM % ${#chars})):1}"
    done
    
    # Shuffle the password
    echo "$password" | fold -w1 | shuf | tr -d '\n'
}

generate_password "${ARG_LENGTH:-32}"
echo ""
