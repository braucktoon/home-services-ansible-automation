# home-services-ansible-automation

When I setup my raspberry pis I often need to do repetitive things:

- set static ip address, router, and DNS in OS
- set hostname in OS
- set locale in OS
- Copy SSH public key to server
- set DNS entry in pihole
- update all packages and upgrade
- install nut client and configure
- Configure backups
- 
- reboot
- install docker and docker-compose on some hosts -  could be it's own role
    - deploy portainer on some hosts or portainer agent on some hosts
    - deploy docker services on some host, traefik, pihole, etc
    - deploy node exporter on all hosts
- harden ssh access
- passwordless sudo
- unattended upgrades - see below
- setup fail2ban?

to configure unattended upgrades
sudo apt-get update
sudo apt-get install unattended-upgrades
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades - turn on automatic reboots
udo dpkg-reconfigure --priority=low unattended-upgrades - configure it to run automatically
sudo systemctl restart unattended-upgrades - restart the service

To install pihole sever, ansible-playbook -b -i inventory --ask-vault-password -u pi main.yml
TODO: I need to tag the roles, I commneted out portainer for example.
