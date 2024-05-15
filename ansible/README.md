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

## Provisioning a Blobscan instance

```
ansible-playbook blobscan.yml -i hosts.yml
ansible-playbook blobscan.yml -i hosts.yml -l sepolia
```

Check if there are manual or unapplied changes to the configuration files:

```
ansible-playbook update-blobscan-config.yml -i hosts.yml --check
```

Update the configuration files:

```
ansible-playbook update-blobscan-config.yml -i hosts.yml
ansible-playbook update-blobscan-config.yml -i hosts.yml -l sepolia
```

Update only the grafana agent:

```
ansible-playbook update-monitoring.yml -i hosts.yml
```

## Provisioning a Swarm node

```
ansible-playbook swarm.yml -i hosts.yml
```

## Provisioning an Ethereum node

```
ansible-playbook ethereum-node.yml -i hosts.yml
ansible-playbook ethereum-node.yml -i hosts.yml -l sepolia_nodes
```

Using ethpandaops roles (only for Gnosis chain at the moment):

```
ansible-playbook ethereum-node-pandaops.yml -i hosts.yml
```
