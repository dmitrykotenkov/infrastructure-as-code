#!/usr/bin/env bash
# =============================================================================
# Ansible Installation Script
# =============================================================================
# Usage:
#   ./ensure-ansible.sh           # Install Ansible (skip if already installed)
#   ./ensure-ansible.sh --upgrade # Upgrade existing Ansible installation
#
# Environment Variables:
#   ANSIBLE_VERSION                # Ansible version to install (default: latest)
#
# Examples:
#   ./ensure-ansible.sh                        # Install latest Ansible
#   ./ensure-ansible.sh --upgrade              # Upgrade to latest Ansible
#   ANSIBLE_VERSION=2.15.0 ./ensure-ansible.sh # Install specific version
# =============================================================================

set -euo pipefail  # exit on error, undefined vars, pipe failures

# =============================================================================
# Configuration
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANSIBLE_DIR="${SCRIPT_DIR}/../ansible"
REQUIREMENTS_FILE="${ANSIBLE_DIR}/requirements.yml"
ANSIBLE_VERSION="${ANSIBLE_VERSION:-latest}"

# =============================================================================
# Pre-flight Checks
# =============================================================================

if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    echo "ERROR: Native Windows detected. Please use WSL." >&2
    exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
    echo "ERROR: Python 3 is not installed." >&2
    exit 1
fi

if ! python3 -c "import sys; sys.exit(0 if sys.version_info >= (3, 8) else 1)"; then
    echo "ERROR: Python 3.8+ is required." >&2
    exit 1
fi

if ! command -v pip3 >/dev/null 2>&1; then
    python3 -m ensurepip --upgrade
fi

# =============================================================================
# Install pip, setuptools, wheel
# =============================================================================

python3 -m pip install --upgrade pip setuptools wheel

# =============================================================================
# Install Ansible
# =============================================================================

if [[ "${1:-}" == "--upgrade" ]]; then
    if [[ "$ANSIBLE_VERSION" == "latest" ]]; then
        python3 -m pip install --upgrade ansible ansible-core
    else
        python3 -m pip install --upgrade ansible=="${ANSIBLE_VERSION}"
    fi
else
    if command -v ansible >/dev/null 2>&1; then
        echo "Ansible is already installed. Use --upgrade to upgrade."
    else
        if [[ "$ANSIBLE_VERSION" == "latest" ]]; then
            python3 -m pip install ansible ansible-core
        else
            python3 -m pip install ansible=="${ANSIBLE_VERSION}"
        fi
    fi
fi

if ! command -v ansible >/dev/null 2>&1; then
    echo "ERROR: Ansible installation failed" >&2
    exit 1
fi

# =============================================================================
# Install Additional Python Dependencies
# =============================================================================

PYTHON_PACKAGES=()

if [ ${#PYTHON_PACKAGES[@]} -gt 0 ]; then
    for package in "${PYTHON_PACKAGES[@]}"; do
        python3 -m pip install "${package}" || true
    done
fi

# =============================================================================
# Install Ansible Galaxy Collections
# =============================================================================

if [[ -f "$REQUIREMENTS_FILE" ]]; then
    ansible-galaxy collection install -r "$REQUIREMENTS_FILE" --upgrade
fi

# =============================================================================
# Verify Installation
# =============================================================================

if ! command -v ansible-playbook >/dev/null 2>&1; then
    echo "ERROR: ansible-playbook is not available" >&2
    exit 1
fi

echo ""
echo "Ansible installation complete"
echo "Version: $(ansible --version | head -n1)"
echo ""
