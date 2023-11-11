# Blobscan infra

Provision and deployment of Blobscan infrastructure

Uses [https://github.com/ethersphere/ansible-role-bee/](ansible-role-bee).

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

And run ansible

```
cd ansible


ansible-playbook setup-monitoring.yml -i hosts -l devnet
ansible-playbook setup-monitoring.yml -i hosts -l eth_nodes

ansible-playbook playbook.yml -i hosts
```

## Provisioning blobscan

```
cd terraform
cp terraform.tfvars.example terraform.tfvars

# adjust your values in terraform.tfvars

terraform workspace new blobstan-staging
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

ip = "34.132.253.15"
```

Write down the IP and add it to your ssh config:

```
Host blobscan-stg
Hostname 34.132.253.15
User your-username
Port 22
```

Now provision it using Ansible:

```
cd ansible
ansible-playbook -i hosts.yml blobscan.yml -l [staging|prod]
```
