#!/bin/bash
networks="staging gnosis hoodi sepolia mainnet"

for env in $networks
do
	pushd $env
	sops decrypt secrets.yaml > secrets_.yaml
	sops encrypt secrets_.yaml > secrets.yaml
	popd
done
