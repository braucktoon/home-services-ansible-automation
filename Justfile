run_media:
    ansible-playbook cd-services.yml -t media -i inventory --vault-password-file .vaultpw

cd_services:
    ansible-playbook cd-services.yml -i inventory --vault-password-file .vaultpw

jenkins:
    ansible-playbook jenkins.yml -i inventory --vault-password-file .vaultpw

nut-proxy:
     ansible-playbook nut-proxy.yml -i inventory --vault-password-file .vaultpw