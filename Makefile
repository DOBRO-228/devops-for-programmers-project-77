install_requirements:
	ansible-galaxy install -r ansible/requirements.yml
update_vault:
	ansible-vault edit ansible/group_vars/all/vault.yml --vault-password-file ansible/vault-password
destroy_infrastructure:
	ansible-playbook ansible/playbook_terraform.yml --vault-password-file ansible/vault-password --extra-vars "terraform_state="absent"
create_infrastructure:
	ansible-playbook ansible/playbook_terraform.yml --vault-password-file ansible/vault-password --extra-vars "terraform_state="present"
deploy:
	ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --vault-password-file ansible/vault-password