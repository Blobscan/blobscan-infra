#!/bin/bash

# Ethereum Goerli (used as staging)
export TF_VAR_network=goerli
export TF_VAR_env=staging
export TF_VAR_database_size=db-s-2vcpu-4gb

export TF_WORKSPACE=blobscan-$TF_VAR_env-goerli
TF_VAR_domain="staging.blobscan.com" terraform apply

# Ethereum Goerli
export TF_VAR_network=goerli
export TF_VAR_env=prod
export TF_VAR_database_size=db-s-2vcpu-4gb

export TF_WORKSPACE=blobscan-$TF_VAR_network-$TF_VAR_env
TF_VAR_domain="$TF_VAR_network.blobscan.com" terraform apply

# Ethereum Testnet Holesky
export TF_VAR_network=holesky
export TF_VAR_env=prod
export TF_VAR_database_size=db-s-1vcpu-2gb

export TF_WORKSPACE=blobscan-$TF_VAR_network-$TF_VAR_env
TF_VAR_domain="$TF_VAR_network.blobscan.com" terraform apply

# Ethereum Testnet Sepolia
export TF_VAR_network=sepolia
export TF_VAR_env=prod
export TF_VAR_database_size=db-s-1vcpu-2gb

export TF_WORKSPACE=blobscan-$TF_VAR_network-$TF_VAR_env
TF_VAR_domain="$TF_VAR_network.blobscan.com" terraform apply

# Ethereum Mainnet
export TF_VAR_network=mainnet
export TF_VAR_env=prod
export TF_VAR_database_size=db-s-2vcpu-4gb

export TF_WORKSPACE=blobscan-$TF_VAR_network-$TF_VAR_env
TF_VAR_domain="blobscan.com" terraform apply
