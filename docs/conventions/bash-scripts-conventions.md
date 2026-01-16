# Bash Scripts Conventions
_dmitrykotenkov/infrastructure-as-code repository_

## Logic Organization

Order of sections in each bash script:

1. Script Header
2. Strict Mode (`set -euo pipefail`)
3. Variables
5. Function(s)
6. Function call with arguments

## Script Header

Every script must include a header with:
- Section with script filename and brief description.
- Section with usage examples, arguments list, environment variables (if applicable) and exit codes.

```bash
#!/bin/bash
# =============================================================================
# script-name.sh - Brief description
# =============================================================================
# Usage:
#   ./script-name.sh [arg1] [arg2]
#
# Arguments:
#   arg1  - Description (default: value)
#   arg2  - Description
#
# Environment Variables:
#   VAR_NAME  - Description (default: value)
#
# Exit codes:
#   0 - Success
#   1 - Failure description
# =============================================================================
```

## Strict Mode

Always use strict mode immediately after header:

```bash
set -euo pipefail
```

- `-e` - Exit on error
- `-u` - Exit on undefined variable
- `-o pipefail` - Exit on pipe failure

## Variables

### Naming Convention

- **Script arguments**: `ARG_NAME` (uppercase with `ARG_` prefix)
- **Local variables**: `lowercase_with_underscores`
- **Environment variables**: `UPPERCASE_WITH_UNDERSCORES`
- **Constants**: `UPPERCASE_WITH_UNDERSCORES`

### Definition

Define argument variables at the top of the script:

```bash
ARG_LENGTH="${1:-32}"
ARG_OPTION="${2:-default}"
```

Define script-level variables after arguments:

```bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/config.yml"
```

## Function(s) - Structure

Wrap main logic in a function:

```bash
script_name() {
    local arg1="$1"
    local arg2="${2:-default}"
    
    # Logic here
    
    return 0
}

script_name "$@"
```

### Function Naming

Use `snake_case` for function names.

## Function(s) - Checks and Validations

### Pre-flight Checks

Place precondition/result validation checks at the beginning/end of the function;  
Ensure result status message just before the return.

```bash
script_name() {
    # Check if required command exists
    if ! command -v python3 &> /dev/null; then
        echo "Python 3 is not installed"
        return 1
    fi
    
    # Main logic follows
    # ...

    # Verify Ansible installation
    if ! command -v ansible &> /dev/null; then
        echo "Ansible installation failed"
        return 1
    fi

    echo "Ansible installation complete"
    ansible --version | head -n1
    
    return 0
}
```

### Comments for Checks

Use clear, action-focused comments:

```bash
# Check if file exists
# Verify installation
# Validate version
```

## Best Practices

- Use `return` in functions, not `exit` (unless script should terminate)
- Keep functions focused on single responsibility

## Current Repository References

### Environment Setup
- [check-python.sh](./../../scripts/check-python.sh) - Check Python installation and version.
- [ensure-python-ubuntu.sh](./../../scripts/ensure-python-ubuntu.sh) - Install or upgrade Python 3.8+ on Ubuntu.
- [ensure-pip-ubuntu.sh](./../../scripts/ensure-pip-ubuntu.sh) - Install pip on Ubuntu.
- [ensure-ansible.sh](./../../scripts/ensure-ansible.sh) - Install Ansible.

### Secret Generation
- [generate-uuid.sh](./../../scripts/generate-uuid.sh) - Generate random UUIDs.
- [generate-number.sh](./../../scripts/generate-number.sh) - Generate random numbers.
- [generate-password.sh](./../../scripts/generate-password.sh) - Generate random passwords.
- [generate-ssh-key-pair.sh](./../../scripts/generate-ssh-key-pair.sh) - Generate ed25519 SSH key pairs.