# Ansible Conventions
_dmitrykotenkov/infrastructure-as-code repository_

## Directory Structure

```
ansible/
├── inventories/
│   └── {project_name}/
│       └── {environment}/
│           ├── hosts.yml
│           ├── group_vars/
│           │   ├── {group_name}.yml
│           │   └── all/
│           │       ├── common.yml
│           │       ├── defaults.yml
│           │       └── vault.yml
│           └── host_vars/
│               └── {host_name}.yml
├── playbooks/
│   ├── _shared/
│   │   └── _playbook_name.yml
│   └── {section_name}/
│       └── playbook_name.yml
└── roles/
    ├── _shared/
    │   └── _{role_name}/
    └── {section_name}/
        └── {role_name}/
```

- Shared roles/playbooks: `_shared` directory, underscore prefix `_`
- Section-specific: placed in section subdirectory (e.g., `1-bootstrap/`)

## Variables Naming

| Scope | Pattern | Example |
|-------|---------|---------|
| Inventory | `{project}__{group}__{name}` | `iac__common__repository_base_directory` |
| Inventory defaults | `_{project}__defaults__{name}` | `_iac__defaults__repository_base_directory` |
| Inventory common | `_{project}__common__{name}` | `_iac__common__repository_base_directory` |
| Role/playbook defaults | `{project}__{section}__{role}__{name}` | `iac__shared__ensure_ssh_key_file__ansible_ssh_private_key` |
| Local (registered) | `__{project}__{section}__{role}__{name}` | `__iac__shared__ensure_ssh_key_file__required` |

- Inventory defaults → `defaults.yml` in inventory `group_vars/all/`
- Inventory common → `common.yml` in inventory `group_vars/all/`
- Role defaults → `defaults/main.yml` in role directory

## Role Structure

### Task Sections

| # | Section | Purpose |
|---|---------|---------|
| 0 | Preconditions | Optional. Determine if role execution is required |
| 1 | Validation | Validate inputs before main execution |
| 2 | Main Tasks | Core logic |
| 3 | Result Validation | Verify execution results |
| 4 | Completion Status | Report final status |

### Task Naming Pattern

```
{Section} | {Role Name} ({Section#}/{Total}) | {Section Name} [{Task#}/{Section Total}] | {Brief Description}
```

Example:
```yaml
- name: Shared | Ensure SSH Key File (2/4) | Main Tasks [1/2] | Create SSH private key file directory if not exists
```

### Brief Description Style

- State/condition: `SSH private key file directory is defined`
- Action: `Create SSH private key file directory if not exists`
- Complex action: `Write SSH private key content to file if not exists or differs`

Keep descriptions **brief** (3-10 words), **action-focused**, **specific**.

### Defaults File Structure

```yaml
---
# =============================================================================
# Required variables (must be set at playbook or inventory level)
# =============================================================================
iac__shared__role_name__required_var: ~

# =============================================================================
# Optional variables (can be overridden at playbook or inventory level)
# =============================================================================
iac__shared__role_name__optional_var: "default_value"
```

- Only include defaults file if role has configurable variables
- Only include section if role has variables of that type
- Two sections: `Required variables`, `Optional variables`
- Omit the section if there are no variables of that type
- Add `(must be set at playbook or inventory level)` when values determined externally
- Add `(can be overridden at playbook or inventory level)` for configurable variables

## Playbook Structure

No sections. Sequential task list with same naming style as roles.

## Task Parameter Order

Recommended order for task parameters:

```yaml
- name: Task description
  # 1. Execution context
  delegate_to: localhost
  become: false
  run_once: true
  
  # 2. Module
  ansible.builtin.module_name:
    # module-specific parameters
    
  # 3. Flow control
  when: condition
  loop: items
  throttle: 1
  
  # 4. Output control
  register: variable_name
  changed_when: false
  failed_when: condition
  no_log: true
  check_mode: false
```

### Parameter Groups

| Order | Group | Parameters |
|-------|-------|------------|
| 1 | Execution context | `delegate_to`, `become`, `become_user`, `run_once` |
| 2 | Module | `ansible.builtin.*:` with module params |
| 3 | Flow control | `when`, `loop`, `with_*`, `throttle`, `retries`, `delay`, `until` |
| 4 | Output control | `register`, `changed_when`, `failed_when`, `no_log`, `check_mode` |

## Section Separators

Use for role task sections:

```yaml
# =============================================================================
# Section 0/4: Preconditions
# =============================================================================
```

## Best Practices

- Always use FQCN: `ansible.builtin.copy`, not `copy`
- Use `changed_when: false` for read-only tasks
- Use `no_log: true` for sensitive data
- Use `throttle: 1` for file operations to prevent race conditions
- Validation assertions: use `quiet: true` for cleaner output

## Current Repository References

### Shared Roles
- [_ensure_ssh_key_file](./../../ansible/roles/_shared/_ensure_ssh_key_file/) - Provision SSH private key file from variable content.
- [_sync_known_hosts](./../../ansible/roles/_shared/_sync_known_hosts/) - Synchronize SSH known hosts.
- [_validate_auth_method](./../../ansible/roles/_shared/_validate_auth_method/) - Validate authentication method configuration.
- [_validate_ssh_key](./../../ansible/roles/_shared/_validate_ssh_key/) - Validate SSH key existence and format.
