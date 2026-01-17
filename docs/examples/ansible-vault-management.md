# Ansible Vault Management Examples
_dmitrykotenkov/infrastructure-as-code repository_

## Encrypt Vault

```bash
# Linux
cd ansible
ansible-vault encrypt inventories/test_lab/dev/group_vars/all/vault.yml
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code/ansible && ansible-vault encrypt inventories/test_lab/dev/group_vars/all/vault.yml'
```

## Decrypt Vault

```bash
# Linux
cd ansible
ansible-vault decrypt inventories/test_lab/dev/group_vars/all/vault.yml
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code/ansible && ansible-vault decrypt inventories/test_lab/dev/group_vars/all/vault.yml'
```

## View Vault (Without Decrypting)

```bash
# Linux
cd ansible
ansible-vault view inventories/test_lab/dev/group_vars/all/vault.yml
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code/ansible && ansible-vault view inventories/test_lab/dev/group_vars/all/vault.yml'
```

## Edit Vault

```bash
# Linux
cd ansible
ansible-vault edit inventories/test_lab/dev/group_vars/all/vault.yml
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code/ansible && ansible-vault edit inventories/test_lab/dev/group_vars/all/vault.yml'
```

## Change Vault Password

```bash
# Linux
cd ansible
ansible-vault rekey inventories/test_lab/dev/group_vars/all/vault.yml
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code/ansible && ansible-vault rekey inventories/test_lab/dev/group_vars/all/vault.yml'
```

## Generate Secrets

### Random Password

```bash
./scripts/generate-password.sh 32
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code && ./scripts/generate-password.sh 32'
```

### SSH Key Pair

```bash
./scripts/generate-ssh-key-pair.sh node1
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code && ./scripts/generate-ssh-key-pair.sh node1'
```

### UUIDs

```bash
# Single UUID
./scripts/generate-uuid.sh

# Multiple UUIDs
./scripts/generate-uuid.sh 5
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code && ./scripts/generate-uuid.sh'
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code && ./scripts/generate-uuid.sh 5'
```

### Random Numbers

```bash
# Single number (0-100)
./scripts/generate-number.sh

# 5 numbers (0-1000)
./scripts/generate-number.sh 5 1000

# 3 numbers (-50 to 50)
./scripts/generate-number.sh 3 50 true
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code && ./scripts/generate-number.sh'
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code && ./scripts/generate-number.sh 5 1000'
wsl -d Ubuntu -e bash -c 'cd /mnt/d/GitHub/dmkt/infrastructure-as-code && ./scripts/generate-number.sh 3 50 true'
```
