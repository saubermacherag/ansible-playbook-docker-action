# ansible-playbook-docker-action
[![Actions Status](https://github.com/saubermacherag/ansible-playbook-docker-action/workflows/Ansible%20Playbook/badge.svg)](https://github.com/saubermacherag/ansible-playbook-docker-action/actions)

Github Action to execute Ansible Playbooks

## Inputs
### `playbookName`
**Required** The name of the playbook to execute.
### `inventoryFile`
**Optional** The name of the inventory file to use.
### `requirementsFile`
**Optional** The name of the requirements file, if you want to install external roles.
This will trigger `ansible-galaxy install -r <requirementsFile>` before your playbook will be called.
### `rolesPath`
**Optional** Additionally to `requirementsFile` above you can specify a custom roles path for your
roles to be installed in. This variable is useless without `requirementsFile`. 
It simply adds `--roles-path <rolesPath>` to the galaxy command.
### `keyFile`
**Optional** ssh keyfile to use for connection to hosts
### `extraFile`
**Optional** File with extra vars to inject in the playbook run.
### `verbosity`
Choose out of 4 verbosity log levels. See ansible documentation for details.

## Example Usage
```yaml
uses: actions/ansible-playbook-docker-action@v1
with:
  playbookName: 'simple-playbook.yml'
  inventoryFile: 'my-inventory.yml'
  requirementsFile: ".ansible/requirements.yml"
  rolesPath: ".ansible/playbooks/roles"
  keyFile: ".ansible/random-ssh-key.pem"
  extraFile: ".ansible/extra.yml"
  verbosity: "vv"
``` 