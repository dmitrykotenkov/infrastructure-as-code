# Ansible
_dmitrykotenkov/infrastructure-as-code repository_

Automation playbooks and roles for infrastructure management.

## Quick Start

```bash
# Run bootstrap preflight (connectivity verification)
ansible-playbook playbooks/01_bootstrap/00_preflight.yml \
  -i inventories/test_lab/dev/hosts.yml \
  --ask-vault-pass
```

## Structure

```
ansible/
├── inventories/          # Environment inventories
│   └── test_lab/dev/     # Development environment
├── playbooks/            # Execution playbooks
│   └── 01_bootstrap/     # Bootstrap phase
├── roles/                # Reusable roles
│   └── _shared/          # Shared utility roles
└── requirements.yml      # Ansible dependencies
```

## Quick Links

| Category | Document | Description |
|----------|----------|-------------|
| **Repository Overview** | [README](../README.md) | Ansible automation project overview |
| **Ansible Runbooks** | [Bootstrap](../docs/runbooks/bootstrap.md) | Host hardening and configuration |
| **Examples** | [Ansible Playbooks Usage](../docs/examples/ansible-playbooks-usage.md) | Limit hosts, dry run, debug |
| | [Ansible Vault Management](../docs/examples/ansible-vault-management.md) | Generate secrets, encrypt/decrypt |
| **Troubleshooting** | [Ansible Connectivity](../docs/troubleshooting/ansible-connectivity.md) | Connection and auth issues |

## Runbooks

- [Bootstrap](../docs/runbooks/bootstrap.md)
