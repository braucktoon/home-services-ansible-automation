#!/bin/bash
#run jenkins
ansible-playbook jenkins.yml -i inventory --vault-password-file ~/vaultpw