#!/bin/bash
# =============================================================================
# ensure-python-ubuntu.sh - Install or upgrade Python 3.8+ on Ubuntu (sudo)
# =============================================================================
# Usage:
#   ./ensure-python-ubuntu.sh
#
# Exit codes:
#   0 - Python 3.8+ installed successfully
#   1 - Installation failed
# =============================================================================

set -euo pipefail

MIN_VERSION="3.8"

ensure_python() {
    local needs_install=false
    
    # Check if Python is installed
    if ! command -v python3 &> /dev/null; then
        needs_install=true
    else
        # Check version
        if ! python3 -c "import sys; sys.exit(0 if sys.version_info >= (3, 8) else 1)"; then
            echo "Python version is below $MIN_VERSION, upgrading..."
            needs_install=true
        fi
    fi
    
    if [[ "$needs_install" == "true" ]]; then
        echo "Installing Python on Ubuntu..."
        
        # Update package list
        sudo apt update
        
        # Install Python and common packages
        sudo apt install -y python3 python3-dev python3-venv
    fi
    
    # Verify installation
    if ! command -v python3 &> /dev/null; then
        echo "Python installation failed"
        return 1
    fi
    
    # Verify version
    if ! python3 -c "import sys; sys.exit(0 if sys.version_info >= (3, 8) else 1)"; then
        echo "Python 3.8+ is required but not available"
        return 1
    fi
    
    echo "Python installed: $(python3 --version)"
    
    return 0
}

ensure_python
