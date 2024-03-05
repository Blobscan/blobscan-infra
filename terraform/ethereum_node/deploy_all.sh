#!/bin/bash
set -ue

deploy_network() {
	export TF_VAR_network=$1
	export TF_VAR_disk_size=$2
	export TF_VAR_zone=$3
	export TF_VAR_instance_type=$4
	export TF_WORKSPACE=ethereum-$1
	terraform apply
}

deploy_network holesky 600 us-central1-a n2-custom-4-36608-ext
deploy_network sepolia 600 us-central1-a c3-standard-4
deploy_network mainnet 2100 us-west1-a n2-custom-4-22016-ext
# broken
deploy_network goerli 600 us-central1-a n2-custom-4-22272
