
requirements:
	@ansible-galaxy install -r requirements.yml

lint:
	@ansible-lint -v playbooks/main.yml

ping:
	@ansible all -m ping

config:
	@ansible-playbook playbooks/main.yml
