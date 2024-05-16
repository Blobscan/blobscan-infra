# Provisioning Swarm nodes

```
cd terraform/swarm_node
cp terraform.tfvars.example terraform.tfvars

# adjust your values in terraform.tfvars

# the workspace name will be the instance name too
terraform workspace new swarm-01
terraform plan
terraform apply
```

Expected output:

```
google_compute_address.static: Creating...
google_compute_address.static: Creation complete after 5s [id=projects/blobscan-379218/regions/us-central1/addresses/swarm-01]
google_compute_instance.instance_with_ip: Creating...
google_compute_instance.instance_with_ip: Still creating... [10s elapsed]
google_compute_instance.instance_with_ip: Creation complete after 16s [id=projects/blobscan-379218/zones/us-central1-a/instances/swarm-01]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

ip = "35.238.112.181"
```

Write down the IP and add it to your ssh config:

```
Host blobscan-swarm
Hostname 35.238.112.181
User your-username
Port 22
```

Now provision it using Ansible:

```
cd ansible
ansible-galaxy install -r requirements.yml
ansible-playbook -i hosts.yml swarm.yml
```

