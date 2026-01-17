# dmitrykotenkov/infrastructure-as-code repository

Infrastructure as Code project for automated infrastructure management.

## Structure

```
├── ansible/              # Ansible automation
├── docs/                 # Documentation
│   ├── conventions/      # Code conventions
│   ├── runbooks/         # Operational guides
│   └── troubleshooting/  # Common issues
└── scripts/              # Helper scripts
```

## Quick Links

| Category | Document | Description |
|----------|----------|-------------|
| **Projects Overview** | [Ansible](ansible/README.md) | Ansible automation project overview |
| **Ansible Runbooks** | [Bootstrap](docs/runbooks/bootstrap.md) | Host hardening and configuration |
| **Examples** | [Ansible Playbooks Usage](docs/examples/ansible-playbooks-usage.md) | Limit hosts, dry run, debug |
| | [Ansible Vault Management](docs/examples/ansible-vault-management.md) | Generate secrets, encrypt/decrypt |
| **Troubleshooting** | [Ansible Connectivity](docs/troubleshooting/ansible-connectivity.md) | Connection and auth issues |
| **Conventions** | [Bash Scripts](docs/conventions/bash-scripts-conventions.md) | Scripting standards and guidelines |

---

## Prerequisites

### WSL Installation (Windows)

Install Windows Subsystem for Linux to run bash scripts and Ansible on your Windows PC:

```powershell
# In PowerShell (Administrator)
wsl --install -d Ubuntu
```

After installation, restart your computer and set up Ubuntu username/password when prompted.
More details: https://learn.microsoft.com/en-us/windows/wsl/install

---

## Ansible

Ansible automation for infrastructure provisioning and configuration management.

### Getting Started

Install prerequisites (run from repository root):

```bash
# On Ubuntu/WSL
./scripts/ensure-python-ubuntu.sh
./scripts/ensure-pip-ubuntu.sh
./scripts/ensure-ansible.sh
```

From PowerShell via WSL:

```powershell
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code && ./scripts/ensure-python-ubuntu.sh && ./scripts/ensure-pip-ubuntu.sh && ./scripts/ensure-ansible.sh'
```

### Inventory Preparation

Create a new inventory from the template for your environment:

```bash
# Linux/WSL
cp -r ansible/inventories/__example ansible/inventories/project_name/dev
```

```powershell
# PowerShell (ensure destination doesn't exist)
Copy-Item ansible/inventories/__example ansible/inventories/project_name/dev -Recurse

# Or use WSL from PowerShell
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code && cp -r ansible/inventories/__example ansible/inventories/project_name/dev'
```

**Inventory structure:**
- **`hosts.yml`** - Defines hosts, groups, and group hierarchies
- **`host_vars/`** - Host-specific variables (one file per host)
- **`group_vars/`** - Group-specific variables
  - **`all/`** - Variables for all hosts
    - **`vault.yml`** - Encrypted secrets (fill with real values and encrypt)

After creating inventory, edit `hosts.yml` with your hosts, configure variables, and prepare vault (see next section).

### Vault Preparation

Vault files store encrypted secrets in `ansible/inventories/project_name/dev/group_vars/all/vault.yml`.

**Create vault file:**

After copying from `__example`, the vault file will be at:
`ansible/inventories/project_name/dev/group_vars/all/vault.yml`

Edit this file with your actual secrets before encrypting.

**Generate secrets for vault:**

```bash
./scripts/generate-password.sh 32        # Random password
./scripts/generate-ssh-key-pair.sh node1 # SSH key pair
./scripts/generate-uuid.sh               # UUID
./scripts/generate-number.sh             # Random number
```

**Encrypt/decrypt vault:**

```bash
# Linux
cd ansible && ansible-vault encrypt inventories/project_name/dev/group_vars/all/vault.yml
cd ansible && ansible-vault decrypt inventories/project_name/dev/group_vars/all/vault.yml
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code/ansible && ansible-vault encrypt inventories/project_name/dev/group_vars/all/vault.yml'
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code/ansible && ansible-vault decrypt inventories/project_name/dev/group_vars/all/vault.yml'
```

### Bootstrap Preflight

Run preflight playbook to verify connectivity before bootstrap:

```bash
# Linux
cd ansible && ANSIBLE_CONFIG=./ansible.cfg ansible-playbook playbooks/1-bootstrap/_preflight.yml -i inventories/project_name/dev/hosts.yml --ask-vault-pass
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code/ansible && ANSIBLE_CONFIG=./ansible.cfg ansible-playbook playbooks/1-bootstrap/_preflight.yml -i inventories/project_name/dev/hosts.yml --ask-vault-pass'
```

_**Do not forget to adjust commands with your actual `project_name` and environment (`dev`, `prod`, etc.).**_

---

### More Ansible Playbooks

See [Bootstrap Runbook](docs/runbooks/bootstrap.md) for additional playbooks and commands.

For advanced usage (limiting hosts, dry run, debug mode), see [Ansible Playbooks Usage Examples](docs/examples/ansible-playbooks-usage.md).

---

## Scripts

Helper scripts for environment setup and secret generation.

### Environment Setup

| Script | Description |
|--------|-------------|
| [check-python.sh](scripts/check-python.sh) | Check Python installation and version |
| [ensure-python-ubuntu.sh](scripts/ensure-python-ubuntu.sh) | Install or upgrade Python 3.8+ on Ubuntu |
| [ensure-pip-ubuntu.sh](scripts/ensure-pip-ubuntu.sh) | Install pip on Ubuntu |
| [ensure-ansible.sh](scripts/ensure-ansible.sh) | Install Ansible |

**check-python.sh** - Check Python 3.8+ availability:
```bash
./scripts/check-python.sh
```
Parameters: `[min_version]` (default: 3.8)

**ensure-python-ubuntu.sh** - Install/upgrade Python:
```bash
./scripts/ensure-python-ubuntu.sh
```

**ensure-pip-ubuntu.sh** - Install pip:
```bash
./scripts/ensure-pip-ubuntu.sh
```

**ensure-ansible.sh** - Install Ansible:
```bash
./scripts/ensure-ansible.sh
```
Parameters: `[--upgrade]`

### Secret Generation

| Script | Description |
|--------|-------------|
| [generate-password.sh](scripts/generate-password.sh) | Generate random password |
| [generate-ssh-key-pair.sh](scripts/generate-ssh-key-pair.sh) | Generate ed25519 SSH key pair |
| [generate-uuid.sh](scripts/generate-uuid.sh) | Generate random UUID |
| [generate-number.sh](scripts/generate-number.sh) | Generate random number |

**generate-password.sh** - Generate random password:
```bash
./scripts/generate-password.sh
```
Parameters: `[length]` (default: 32)

**generate-ssh-key-pair.sh** - Generate SSH key pair:
```bash
./scripts/generate-ssh-key-pair.sh
```
Parameters: `[comment]` (default: generated-key)

**generate-uuid.sh** - Generate UUID:
```bash
./scripts/generate-uuid.sh
```
Parameters: `[amount]` (default: 1)

**generate-number.sh** - Generate random number:
```bash
./scripts/generate-number.sh
```
Parameters: `[amount]` `[range]` `[include_negative]` (defaults: 1, 100, false)
