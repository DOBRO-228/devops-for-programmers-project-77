### Hexlet tests and linter status:
[![Actions Status](https://github.com/DOBRO-228/devops-for-programmers-project-77/workflows/hexlet-check/badge.svg)](https://github.com/DOBRO-228/devops-for-programmers-project-77/actions)

### Requirements

- Ansible
- Terraform
- make

### Step 1. Setup Digital Ocean

1. Create an account on Digital Ocean by clicking on the [link](https://m.do.co/c/e702f9a99145)
2. Add a DO token as `DO_TOKEN` to Ansible vault `ansible/group_vars/all/vault.yml`
3. Add a ssh key to DO account and add path to private key as `DO_SSH_PVT_KEY_PATH` to Ansible vault `ansible/group_vars/all/vault.yml`

### Step 2. Setup DataDog

1. Create a DataDog account
2. Add an api token as `DATADOG_API_KEY`, an app token as `DATADOG_APP_KEY` and a datadog site as `DATADOG_APP_KEY` to Ansible vault `ansible/group_vars/all/vault.yml`

### Step 3. Setup Ansible

1. Install Ansible requirements: `make install_requirements`
2. Encrypt vault: `ansible-vault encrypt ansible/group_vars/all/vault.yml`
3. Create file with vault password at the directory `./ansible/` with name `vault-password`

### Step 4. Create terraform infrastructure

1. Create terraform infrastructure: `make create_infrastructure`
2. Ansible will ask you to enter a domain name. Skip it (press enter) if yoy want to choose a default domain name `228.dobro-228.ru`
3. Wait about 20-30 mins

### Step 5. Setup webservers

1. `make setup`

### Step 7. Release application

1. `make deploy`

#### URL

`https://228.dobro-228.ru/`

## Make commands

- Install requirements: `make install_requirements`
- Update vault: `make update_vault`
- Create infrastructure: `make create_infrastructure`
- Destroy infrastructure: `make destroy_infrastructure`
- Setup servers: `make setup`
- Deploy app: `make deploy`
