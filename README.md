# ansible-playbook-docker-action
[![Actions Status](https://github.com/saubermacherag/ansible-playbook-docker-action/workflows/Ansible%20Playbook/badge.svg)](https://github.com/saubermacherag/ansible-playbook-docker-action/actions)

Github Action to execute Ansible Playbooks using fixed Ansible versions.

| Action Version | Ansible Version |
|:--------------:|:---------------:|
|      v1.3      |      2.8.5      |
|      v1.4      |      2.9.11     |

## Inputs
### `playbookName`
**Required** The name of the playbook to execute.
### `inventoryFile`
**Optional** The name of the inventory file to use.
### `requirementsFile`
**Optional** The name of the requirements file, if you want to install external roles.
This will trigger `ansible-galaxy install -r <requirementsFile>` before your playbook will be called.
### `galaxyGithubUser`
**Optional** If you use private github repositories in your requirements file you need to set galaxyGithubUser and galaxyGithub token.
### `galaxyGithubToken`
**Optional** Token to access git source of roles to download. Only needed for private git sources. Github Account needs to be linked to Ansible Galaxy.
### `rolesPath`
**Optional** Additionally to `requirementsFile` above you can specify a custom roles path for your
roles to be installed in. This variable is useless without `requirementsFile`. 
It simply adds `--roles-path <rolesPath>` to the galaxy command.
### `keyFile`
**Optional** ssh keyfile to use for connection to hosts. If vaulted use `keyFileVaultPass` to decrypt.
### `keyFileVaultPass`
**Optional** Vault Password to decrypt `keyfile`.
### `extraVars`
**Optional** A String containing extra variables separated by spaces to inject in the playbook run.
### `extraFile`
**Optional** File with extra vars to inject in the playbook run.
Especially useful when you want to inject environment variables. In such a case `extraFile` doesn't suffice.
### `verbosity`
Choose out of 4 verbosity log levels. See ansible documentation for details.

## Example Usage
```yaml
uses: saubermacherag/ansible-playbook-docker-action@v1.4
with:
  playbookName: 'simple-playbook.yml'
  inventoryFile: 'my-inventory.yml'
  requirementsFile: ".ansible/requirements.yml"
  galaxyGithubUser: ${{ secrets.GITHUB_USER }}
  galaxyGithubToken: ${{ secrets.Github_PAT }}
  rolesPath: ".ansible/playbooks/roles"
  keyFile: ".ansible/random-ssh-key.pem"
  keyFileVaultPass: ${{ secrets.KEYFILE_VAULT_PASS }}
  extraFile: ".ansible/extra.yml"
  extraVars: "-e my_first_extra=${{ github.actor }} -e my_second_one=${{ github.sha }}"
  verbosity: "vv"
``` 
