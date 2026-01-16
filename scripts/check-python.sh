#!/bin/bash
# =============================================================================
# check-python.sh - Check Python installation and version
# =============================================================================
# Usage:
#   ./check-python.sh [min_version]
#
# Arguments:
#   min_version  - Minimum required Python version (default: 3.8)
#
# Exit codes:
#   0 - Python meets requirements
#   1 - Python not found or version too old
# =============================================================================

set -euo pipefail

ARG_MIN_VERSION="${1:-3.8}"

check_python() {
    local min_version="$1"
    
    # Check if python3 is available
    if ! command -v python3 &> /dev/null; then
        echo "Python 3 is not installed"
        echo "Install: sudo apt install python3 python3-pip"
        return 1
    fi
    
    # Get Python version
    local python_version
    python_version=$(python3 --version 2>&1 | awk '{print $2}')
    
    # Compare versions
    local min_version_num
    local python_version_num
    min_version_num=$(echo "$min_version" | awk -F. '{printf "%d%03d%03d", $1, $2, $3}')
    python_version_num=$(echo "$python_version" | awk -F. '{printf "%d%03d%03d", $1, $2, $3}')
    
    if [ "$python_version_num" -lt "$min_version_num" ]; then
        echo "Python version $python_version is too old (required: $min_version+)"
        return 1
    fi
    
    echo "Python $python_version"
    
    # Check pip
    if command -v pip3 &> /dev/null; then
        pip3 --version
    else
        echo "pip not found"
        return 1
    fi
    
    return 0
}

check_python "$ARG_MIN_VERSION"
