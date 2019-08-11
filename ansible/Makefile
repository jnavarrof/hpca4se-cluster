
requirements:
	@ansible-galaxy install -r requirements.yml -p roles/

lint:
	@ansible-lint -v playbooks/site.yml

ping:
	@ansible all -m ping

config:
	@ansible-playbook playbooks/site.yml
