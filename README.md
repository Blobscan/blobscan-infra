# Blobscan infra

This repository contains Infrastructure as Code (IaC) resources to deploy
and provision Blobscan to a Kubernetes cluster.

If you want to check out our previous infrastructure using GCP VMs, provisioned using Terraform and Ansible,
check out the [legacy branch](https://github.com/Blobscan/blobscan-infra/tree/legacy) in this repository.

## Install dependencies

* Helm
* Helmfile
* SOPS

## Deploy databases

```
cd databases
helmfile apply
```

## Deploy blobscan

```
cd environments
./apply_all.sh
```
