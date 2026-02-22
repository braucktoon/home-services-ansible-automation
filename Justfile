lint:
    yamllint .
    ANSIBLE_VAULT_PASSWORD_FILE=.vaultpw ansible-lint
    SHELLCHECK=~/.local/bin/shellcheck ./scripts/shellcheck-backups.sh

run_media:
    ansible-playbook cd-services.yml -t media -i inventory --vault-password-file .vaultpw

cd_services:
    ansible-playbook cd-services.yml -i inventory --vault-password-file .vaultpw

jenkins:
    ansible-playbook jenkins.yml -i inventory --vault-password-file .vaultpw

nut-proxy:
     ansible-playbook nut-proxy.yml -i inventory --vault-password-file .vaultpw

site:
     ansible-playbook site.yml -i inventory --vault-password-file .vaultpw

run-backups backup="*":
    ansible-playbook run-backups.yml -i inventory --vault-password-file .vaultpw -e "backup_filter={{ backup }}"