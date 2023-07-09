install_requirements:
	ansible-galaxy install -r ansible/requirements.yml
update_vault:
	ansible-vault edit ansible/group_vars/all/vault.yml
destroy:
	terraform -chdir=terraform/ destroy
create_infrastructure:
	ansible-playbook ansible/playbook_terraform.yml
deploy:
	ansible-playbook -i ansible/inventory.ini ansible/playbook.yml