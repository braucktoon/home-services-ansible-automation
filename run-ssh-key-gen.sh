#!/bin/bash
#run ssh-key-gen
ansible-playbook site.yml -t ssh-key-gen,ssh-config-for-backups,ssh-config-for-build-server -i inventory --vault-password-file ~/vaultpw --ask-become-pass