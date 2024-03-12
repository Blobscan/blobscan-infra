#!/bin/bash
set -ue

deploy_node() {
	export TF_VAR_network=$1
	export TF_VAR_disk_size=$2
	export TF_VAR_zone=$3
	export TF_VAR_instance_type=$4
	export TF_WORKSPACE=ethereum-$1
	terraform apply
}

deploy_node holesky 600 us-central1-a n2-custom-4-36608-ext
deploy_node sepolia 600 us-central1-a c3-standard-4
deploy_node mainnet 2100 us-west1-a n2-custom-4-22016-ext
deploy_node gnosis 1024 us-west1-a n2-custom-4-22272
