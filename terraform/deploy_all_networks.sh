#!/bin/bash

# Ethereum Goerli (used as staging)
export TF_VAR_network=goerli
export TF_VAR_environment=staging
export TF_VAR_database_size=db-s-2vcpu-4gb

export TF_WORKSPACE=blobscan-$environment-goerli
TF_VAR_api_domain="api.staging.blobscan.com" terraform apply

# Ethereum Goerli
export TF_VAR_network=goerli
export TF_VAR_environment=prod
export TF_VAR_database_size=db-s-2vcpu-4gb

export TF_WORKSPACE=blobscan-$network-$environment
TF_VAR_api_domain="api.$network.blobscan.com" terraform apply

# Ethereum Testnet Holesky
export TF_VAR_network=holesky
export TF_VAR_environment=prod
export TF_VAR_database_size=db-s-1vcpu-2gb

export TF_WORKSPACE=blobscan-$network-$environment
TF_VAR_api_domain="api.$network.blobscan.com" terraform apply

# Ethereum Testnet Sepolia
export TF_VAR_network=sepolia
export TF_VAR_environment=prod
export TF_VAR_database_size=db-s-1vcpu-2gb

export TF_WORKSPACE=blobscan-$network-$environment
TF_VAR_api_domain="api.$network.blobscan.com" terraform apply

# Ethereum Mainnet
export TF_VAR_network=mainnet
export TF_VAR_environment=prod
export TF_VAR_database_size=db-s-2vcpu-4gb

export TF_WORKSPACE=blobscan-$network-$environment
TF_VAR_api_domain="api.blobscan.com" terraform apply
