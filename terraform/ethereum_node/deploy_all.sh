#!/bin/bash

network=holesky
export TF_WORKSPACE=ethereum-$network
TF_VAR_network=$network terraform apply

network=sepolia
export TF_WORKSPACE=ethereum-$network
TF_VAR_network=$network terraform apply

network=mainnet
export TF_WORKSPACE=ethereum-$network
TF_VAR_network=$network terraform apply
