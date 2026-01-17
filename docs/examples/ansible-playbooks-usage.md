# Ansible Playbooks Usage Examples
_dmitrykotenkov/infrastructure-as-code repository_

## Limit Hosts

Run playbook only on specific hosts:

```bash
# Linux
cd ansible
ANSIBLE_CONFIG=./ansible.cfg ansible-playbook playbooks/1-bootstrap/_preflight.yml \
  -i inventories/project_name/dev/hosts.yml \
  --limit node1,node2 \
  --ask-vault-pass
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code/ansible && ANSIBLE_CONFIG=./ansible.cfg ansible-playbook playbooks/1-bootstrap/_preflight.yml -i inventories/project_name/dev/hosts.yml --limit node1,node2 --ask-vault-pass'
```

## Dry Run (Check Mode)

Test playbook without making changes:

```bash
# Linux
cd ansible
ANSIBLE_CONFIG=./ansible.cfg ansible-playbook playbooks/1-bootstrap/_preflight.yml \
  -i inventories/project_name/dev/hosts.yml \
  --check \
  --ask-vault-pass
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code/ansible && ANSIBLE_CONFIG=./ansible.cfg ansible-playbook playbooks/1-bootstrap/_preflight.yml -i inventories/project_name/dev/hosts.yml --check --ask-vault-pass'
```

## Debug Output

Run with verbose output for troubleshooting:

```bash
# Linux
cd ansible
ANSIBLE_CONFIG=./ansible.cfg ansible-playbook playbooks/1-bootstrap/_preflight.yml \
  -i inventories/project_name/dev/hosts.yml \
  -vvv \
  --ask-vault-pass
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code/ansible && ANSIBLE_CONFIG=./ansible.cfg ansible-playbook playbooks/1-bootstrap/_preflight.yml -i inventories/project_name/dev/hosts.yml -vvv --ask-vault-pass'
```

## Using Vault Password File

Avoid entering vault password interactively:

```bash
# Linux
cd ansible
ANSIBLE_CONFIG=./ansible.cfg ansible-playbook playbooks/1-bootstrap/_preflight.yml \
  -i inventories/project_name/dev/hosts.yml \
  --vault-password-file .vault_pass
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code/ansible && ANSIBLE_CONFIG=./ansible.cfg ansible-playbook playbooks/1-bootstrap/_preflight.yml -i inventories/project_name/dev/hosts.yml --vault-password-file .vault_pass'
```
