# Blobscan infra

Provision and deployment of Blobscan infrastructure

Uses [https://github.com/ethersphere/ansible-role-bee/](ansible-role-bee).

## Provision ethswarm node with Ansible

```
asdf install
ansible-galaxy install ethersphere.bee

cd ansible
ansible-playbook playbook.yml -i hosts
```
