# Bootstrap Runbook
_dmitrykotenkov/infrastructure-as-code repository_

Bootstrap is a comprehensive host hardening process including initialization, upgrades, base configuration, authentication and firewall.

## Preflight

Pre-step to ensure bootstrap can run: validates auth → provisions SSH keys → syncs known_hosts → verifies connection

```bash
# Linux
cd ansible
ANSIBLE_CONFIG=./ansible.cfg ansible-playbook playbooks/1-bootstrap/_preflight.yml \
  -i inventories/project_name/dev/hosts.yml \
  --ask-vault-pass
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code/ansible && ANSIBLE_CONFIG=./ansible.cfg ansible-playbook playbooks/1-bootstrap/_preflight.yml -i inventories/project_name/dev/hosts.yml --ask-vault-pass'
```
