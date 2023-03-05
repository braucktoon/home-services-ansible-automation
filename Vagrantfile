Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"

  # Ansible provisioner.
  config.vm.provision :ansible do |ansible|
    ansible.playbook = "main.yml"
    ansible.become = true
    ansible.ask_vault_pass = true
  end
end
