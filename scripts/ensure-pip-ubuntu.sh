#!/bin/bash
# =============================================================================
# ensure-pip-ubuntu.sh - Install pip on Ubuntu if missing
# =============================================================================
# Usage:
#   ./ensure-pip-ubuntu.sh
#
# Exit codes:
#   0 - pip installed successfully
#   1 - Installation failed or Python not found
# =============================================================================

set -euo pipefail

ensure_pip() {
    # Check if Python is installed
    if ! command -v python3 &> /dev/null; then
        echo "Python 3 is not installed"
        echo "Install: ./ensure-python-ubuntu.sh"
        return 1
    fi
    
    # Check if pip is already installed
    if command -v pip3 &> /dev/null; then
        echo "pip is already installed: $(pip3 --version)"
        return 0
    fi
    
    echo "Installing pip on Ubuntu..."
    
    # Update package list
    sudo apt update
    
    # Install pip
    sudo apt install -y python3-pip
    
    # Upgrade pip, setuptools, wheel
    python3 -m pip install --upgrade pip setuptools wheel
    
    # Verify installation
    if command -v pip3 &> /dev/null; then
        echo "pip installed successfully: $(pip3 --version)"
        return 0
    else
        echo "pip installation failed"
        return 1
    fi
}

ensure_pip
