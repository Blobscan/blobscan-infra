#!/bin/bash
set -u

deploy_network() {
	export TF_VAR_network=$1
	export TF_VAR_env=$2
	export TF_VAR_domain="$3"
	export TF_WORKSPACE=blobscan-$1-$2
	export TF_VAR_database_size=$4
	terraform apply
}

# Ethereum Goerli (used as staging)
export TF_VAR_network=goerli
export TF_VAR_env=staging
export TF_VAR_domain=staging.blobscan.com
export TF_WORKSPACE=blobscan-$TF_VAR_env-goerli
terraform apply

# Ethereum Goerli
deploy_network goerli prod goerli.blobscan.com db-s-2vcpu-4gb

# Ethereum Testnet Holesky
deploy_network holesky prod holesky.blobscan.com db-s-1vcpu-2gb

# Ethereum Testnet Sepolia
deploy_network sepolia prod sepolia.blobscan.com db-s-1vcpu-2gb

# Ethereum Mainnet
deploy_network mainnet prod blobscan.com db-s-2vcpu-4gb
