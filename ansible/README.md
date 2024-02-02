# Provision Blobscan using Ansible

This repository contains the following ansible playbooks:

* blobscan.yml
* ethereum-node.yml
* swarm.yml

## Prerequisites

Install the requirements

```
ansible-galaxy install -r requirements.yml
```

# Playbooks

## Provisioning an Ethereum node

```
ansible-playbook ethereum-node.yml -i hosts.yml
```

## Provisioning a Swarm node

```
ansible-playbook swarm.yml -i hosts.yml
```

## Provisioning a Blobscan instance

```
ansible-playbook blobscan.yml -i hosts.yml [-l ...]
```

Check if there are manual or unapplied changes to the configuration files:

```
ansible-playbook update-blobscan-config.yml -i hosts.yml --check
```

Update the configuration files:

```
ansible-playbook update-blobscan-config.yml -i hosts.yml
```
