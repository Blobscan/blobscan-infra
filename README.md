# Blobscan infra

This repository contains Infrastructure as Code (IaC) resources to deploy
and provision Blobscan.

Uses [https://github.com/ethersphere/ansible-role-bee/](ansible-role-bee) among other [ansible requirements](ansible/requirements.yml).

Features:

* Terraform for managing infra
* Ansible for provisioning
* Grafana Agent for monitoring

## Install dependencies

**Terraform**

From https://developer.hashicorp.com/terraform/install

```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

**Ansible**

```
sudo apt install ansible
```

## Ansible Playbooks

The following playbooks are provided:

* `blobscan.yml`
* `ethereum-node.yml`
* `swarm.yml`

These are used to provision Blobscan instances, and Ethereum and Swarm nodes.

## Provision Ethereum node

```
cd terraform/ethereum_node
terraform workspace new ethereum-holesky
terraform -var="network=holesky" apply

cd ../../ansible

# 1. add host to ssh-config
# 2. add host to hosts.yml
# 3. in case of a new network, add environments/${network}/

ansible-playbook ethereum-node.yml -i hosts.yml -l ethereum-holesky
```

## Provision Ethereum Swarm node

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
ansible-galaxy collection install grafana.grafana
```

Edit the hosts file.

And run ansible

```
cd ansible
ansible-playbook swarm.yml -i hosts.yml -l swarm
```

## Provisioning blobscan

We are going to setup blobscan from scratch, first creating the infrastructure and then provisioning and configuring blobscan on it.

In this case we are setting up a blobscan instance for Goerli Testnet (network="goerli") in production (env="prod").

```
cd terraform

# adjust your values in terraform.tfvars
cp terraform.tfvars.example terraform.tfvars

# the workspace name will be the instance name too
terraform workspace new blobscan-goerli-prod
export TF_VAR_env=prod
export TF_VAR_network=goerli
terraform plan
terraform apply
```

Expected output:

```
google_compute_address.static: Creating...
google_compute_address.static: Creation complete after 3s [id=projects/blobscan-379218/regions/us-central1/addresses/ipv4-address]
google_compute_instance.instance_with_ip: Creating...
google_compute_instance.instance_with_ip: Still creating... [10s elapsed]
google_compute_instance.instance_with_ip: Creation complete after 17s [id=projects/blobscan-379218/zones/us-central1-a/instances/blobscan-staging]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

db_host = "blobscan-goerli-prod-do-user-2001904-0.c.db.ondigitalocean.com"
db_port = 25060
domain_api = "api.goerli.blobscan.com."
domain_web = "goerli.blobscan.com."
ip = "34.132.253.15"
vm_private_ip = "10.128.1.31"

```

Write down the IP and add it to your ssh config:

```
Host blobscan-goerli-prod
Hostname 34.132.253.15
```

Log in to Digital Ocean [Databases](https://cloud.digitalocean.com/databases) and write down the postgres credentials. Then, create a vault file like `ansible/environments/prod/group_vars/vault_goerli.yml` (or use it as template) and edit `vault_database_url`. Enter the vm_private_ip output into `environments/goerli/group_vars/all` and modify accordingly.

Lastly, provision everything using Ansible:

```
cd ansible
ansible-playbook -i hosts.yml blobscan.yml -l staging
```

Note: currently, you must log into your instance and start the docker compose services by yourself.
