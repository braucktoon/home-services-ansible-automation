#!/bin/bash
#run ssh-key-gen
ansible-playbook site.yml -t ssh-key-gen -i inventory --vault-password-file ~/vaultpw --ask-become-pass