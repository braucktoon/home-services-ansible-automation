# home-services-ansible-automation

site.yml, an ansible playbook that secures my raspberry pis, installs docker, and NUT client via ansible roles
<br>
cd-services.yml, an ansible playbok that sets up my home services via ansible roles
<br>
nas.yml, an ansible playbook that sets up backup shares on my synology via ansible roles
<br>
jenkins.yml, sets up jenkis for continuous deliver and upgrade of the ansible services
<br>
jenkinsfile-1, the jenkins pipeline script that builds the Dockerfile which deploys and updates the home services in cd-services.yml
<br>
use at your own risk.