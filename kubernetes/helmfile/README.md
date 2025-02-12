## Helm

```
helm install cnpg cnpg/cloudnative-pg -n cnpg-system
helm install blobscan-gnosis-db ./helm/cloudnative-pg/charts/cluster/ -n gnosis --values values/blobscan.yaml --values values/gnosis.yaml
helm upgrade blobscan-sepolia-db ./helm/cloudnative-pg/charts/cluster/ -n sepolia --values values/blobscan.yaml --values values/sepolia.yaml --values values/sepolia-import.yaml
```

Uses chart with this PR https://github.com/cloudnative-pg/charts/pull/475

Create do-migration-db secrets (doadmin DB password):

```
echo password=XXXXXXXXXX > secrets/gnosis.env
```

Do the magic:

```
helmfile diff
helmfile apply
```

## Create secrets

```
#!/bin/bash
for namespace in gnosis staging sepolia holesky mainnet preview; do
        echo ""
        echo "Namespace: $namespace"
        echo ""
        # kubectl delete secret backup-creds  -n $namespace
        kubectl create secret generic backup-creds --from-env-file=secrets_backup.env -n $namespace
        kubectl create secret generic do-migration-db --from-env-file=secrets/$namespace.env -n $namespace
done
```
