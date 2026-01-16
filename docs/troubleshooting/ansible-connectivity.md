# Ansible Connectivity Troubleshooting
_dmitrykotenkov/infrastructure-as-code repository_

## Test Connectivity

Test if a machine with Ansible can reach hosts:

```bash
# Linux
ping hostname -c 4
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'ping hostname -c 4'
```

## Clear known_hosts

Remove host keys from known_hosts file:

```bash
# Linux
ssh-keygen -R hostname
ssh-keygen -R [hostname]:port
```

```powershell
# PowerShell via WSL
wsl -d Ubuntu -e bash -c 'ssh-keygen -R hostname && ssh-keygen -R [hostname]:port'
```

## SSH Connection Issues

### Permission Denied

**Check:**
- Vault has correct credentials
- SSH key has proper permissions (0600)
- User has SSH access to target host

### Host Key Verification Failed

**Solution:** Clear known_hosts entry and retry

### Connection Timeout

**Check:**
- Host is reachable: `ping hostname`
- SSH port is open: `nc -zv hostname port`
- Firewall rules allow SSH

## Ansible Errors

### "Vault password incorrect"

**Causes:**
- Wrong password entered
- Vault file corrupted
- File not actually encrypted

**Solution:** Verify vault password, re-encrypt if needed

### "Host not found in inventory"

**Check:**
- Host defined in hosts.yml
- Group name correct in playbook
- Inventory file path correct

### "Authentication failed"

**Check:**
- ansible_user configured correctly
- Password/SSH key valid
- Initial auth credentials in vault match actual host
