# home-services-ansible-automation

site.yml, an ansible playbook that secures my raspberry pis, installs docker, and NUT client via ansible roles
<p>
cd-services.yml, an ansible playbok that sets up my home services via ansible roles
<p>
nas.yml, an ansible playbook that sets up backup shares on my synology via ansible roles
<p>
jenkins.yml, sets up jenkin server for continuous delivery of the home services
<p>
jenkinsfile-1, the jenkins pipeline script that builds the Dockerfile which deploys and updates the home services in cd-services.yml playbook.
<p>
use at your own risk.