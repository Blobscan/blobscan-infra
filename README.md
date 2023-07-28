# Blobscan infra

Provision and deployment of Blobscan infrastructure

Uses [https://github.com/ethersphere/ansible-role-bee/](ansible-role-bee).

## Provision ethswarm node with Ansible

add host to `$HOME/.ssh/config`

```
Host blobscan-swarm
Hostname <SERVER-IP>
Port 22
User root
LocalForward 1633 localhost:1633
LocalForward 1635 localhost:1635
```

Then install requirements

```
asdf install
ansible-galaxy install ethersphere.bee
```

And run ansible

```
cd ansible
ansible-playbook playbook.yml -i hosts
```
