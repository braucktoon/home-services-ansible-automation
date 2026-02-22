# Home Services Ansible Automation

Ansible automation for a home lab running Docker-based services across Raspberry Pi and Synology NAS hosts.

## Network & Hosts

| Host | IP | User | Role |
|------|-----|------|------|
| gomey | 10.0.0.10 | pi | Pihole DNS/ad-blocker |
| nas | 10.0.0.2 | dmcgough | Synology NAS (backup target, NFS) |
| floof | 10.0.0.7 | pi | Home Assistant + Zigbee/Z-Wave/Scrypted |
| lola | 10.0.0.8 | pi | Monitoring (Portainer, Uptime Kuma, Vaultwarden) |
| biggie | 10.0.0.9 | pi | Jenkins CI/CD |
| media | 10.0.0.15 | media | Media stack (Jellyfin, Sonarr, Radarr, SABnzbd, Prowlarr, Qbittorrent, Gluetun) |
| new-proxy | 10.0.0.233 | pi | NUT UPS proxy + Keepalived |
| banana/fluff | 10.0.0.14/4 | pi | Dev/testing hosts |

## Playbooks

| Playbook | Justfile Shortcut | Purpose |
|----------|-------------------|---------|
| `site.yml` | *(none)* | Base system hardening: security, Docker, NUT client, SSH |
| `cd-services.yml` | `just cd_services` | Deploy all home services |
| `cd-services.yml -t media` | `just run_media` | Deploy media stack only |
| `jenkins.yml` | `just jenkins` | Deploy Jenkins on biggie |
| `nut-proxy.yml` | `just nut-proxy` | Deploy UPS proxy on new-proxy |

## Running Playbooks

All playbooks require the vault password file `.vaultpw`:

```bash
ansible-playbook cd-services.yml -i inventory --vault-password-file .vaultpw
# or use justfile shortcuts:
just cd_services
just run_media
just jenkins
just nut-proxy
```

## Key Variables

- `docker_dir: /data` — Docker volumes/data root on all service hosts
- `backups_dir: /backups` — Backup destination directory
- NFS mounts from NAS: `/volume1/media` and `/volume1/docker`

## Roles (27 total)

**Infrastructure:**
- `docker` — Install Docker + Docker Compose
- `security` — Hardening: fail2ban, SSH, unattended-upgrades, sudo
- `ssh-key-gen` — SSH key pair generation/distribution

**Services:**
- `pihole`, `heimdall`, `home-assistant`, `mosquitto`, `zigbee2mqtt`, `zwavejs`, `scrypted`
- `uptime-kuma`, `portainer`, `portainer-agent`, `proxy`, `vaultwarden`
- `unbound`, `tailscale`

**Media & Backup:**
- `media` — Full media stack with NFS mounts and cron-based backups
- `jenkins` — Jenkins CI/CD server
- `setup-nas-for-backups` — NAS backup prep

**Network/HA:**
- `nut-client`, `nginx-nut-proxy`, `keepalived-master`, `keepalived-backup`, `node-exporter`

## Collections Required

Install via: `ansible-galaxy collection install -r requirements.yml`

- `community.docker >= 4.0.0`
- `community.general >= 11.0.0`
- `ansible.posix >= 2.0.0`

## Secrets

Ansible Vault is used for sensitive variables. Password stored in `.vaultpw` (git-ignored).

To encrypt a variable:
```bash
ansible-vault encrypt_string 'value' --name 'var_name' --vault-password-file .vaultpw
```
