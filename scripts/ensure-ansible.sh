#!/bin/bash
# =============================================================================
# ensure-ansible.sh - Install Ansible if missing
# =============================================================================
# Usage:
#   ./ensure-ansible.sh [--upgrade]
#
# Arguments:
#   --upgrade  - Upgrade existing Ansible installation
#
# Environment Variables:
#   ANSIBLE_VERSION  - Ansible version to install (default: latest)
#
# Exit codes:
#   0 - Ansible installed successfully
#   1 - Installation failed or requirements not met
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANSIBLE_DIR="${SCRIPT_DIR}/../ansible"
REQUIREMENTS_FILE="${ANSIBLE_DIR}/requirements.yml"
ANSIBLE_VERSION="${ANSIBLE_VERSION:-latest}"

ensure_ansible() {  
    # Check if Python is installed
    if ! command -v python3 &> /dev/null; then
        echo "Python 3 is not installed"
        return 1
    fi
    
    # Check if Python has appropriate version
    if ! python3 -c "import sys; sys.exit(0 if sys.version_info >= (3, 8) else 1)"; then
        echo "Python 3.8+ is required"
        return 1
    fi
    
    # Check if pip is installed
    if ! command -v pip3 &> /dev/null; then
        echo "pip is not installed"
        return 1
    fi
    
    # Install or upgrade Ansible
    if [[ "${1:-}" == "--upgrade" ]]; then
        if [[ "$ANSIBLE_VERSION" == "latest" ]]; then
            python3 -m pip install --upgrade ansible ansible-core
        else
            python3 -m pip install --upgrade ansible=="${ANSIBLE_VERSION}"
        fi
    else
        if command -v ansible &> /dev/null; then
            echo "Ansible is already installed. Use --upgrade to upgrade"
        else
            if [[ "$ANSIBLE_VERSION" == "latest" ]]; then
                python3 -m pip install ansible ansible-core
            else
                python3 -m pip install ansible=="${ANSIBLE_VERSION}"
            fi
        fi
    fi
    
    # Verify Ansible installation
    if ! command -v ansible &> /dev/null; then
        echo "Ansible installation failed"
        return 1
    fi
    
    # Install Ansible Galaxy collections
    if [[ -f "$REQUIREMENTS_FILE" ]]; then
        ansible-galaxy collection install -r "$REQUIREMENTS_FILE" --upgrade
    fi
    
    # Verify ansible-playbook
    if ! command -v ansible-playbook &> /dev/null; then
        echo "ansible-playbook is not available"
        return 1
    fi
    
    echo "Ansible installation complete"
    ansible --version | head -n1
    
    return 0
}

ensure_ansible "$@"
