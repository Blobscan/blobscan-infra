#!/bin/bash
set -u

deploy_blobscan() {
	export TF_VAR_network=$1
	export TF_VAR_env=$2
	export TF_VAR_domain="$3"
	export TF_WORKSPACE=blobscan-$1-$2
	export TF_VAR_database_size=$4
	terraform apply
}

# (blobscan staging) Ethereum Mainnet
deploy_blobscan mainnet staging staging.blobscan.com db-s-1vcpu-2gb

# Ethereum Testnet Holesky
deploy_blobscan holesky prod holesky.blobscan.com db-s-1vcpu-2gb

# Ethereum Testnet Sepolia
deploy_blobscan sepolia prod sepolia.blobscan.com db-s-1vcpu-2gb

# Ethereum Mainnet
deploy_blobscan mainnet prod blobscan.com db-s-2vcpu-4gb

# Gnosis chain
deploy_blobscan gnosis prod gnosis.blobscan.com db-s-1vcpu-2gb
