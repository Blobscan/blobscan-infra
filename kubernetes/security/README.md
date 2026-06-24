# Cluster security hardening

Manifests and runbook for the network-isolation and pod-hardening controls
from the security review. These are applied with `kubectl`, not helmfile, so
they can be rolled out gradually and watched.

## 1. Database NetworkPolicies

`netpol-database.yaml` restricts who can reach Postgres (5432) — instances and
PgBouncer poolers — to same-namespace workloads plus the `cnpg-system` and
`monitoring` namespaces. Apply per database namespace:

```bash
for ns in staging mainnet gnosis sepolia hoodi holesky; do
  kubectl -n "$ns" apply -f kubernetes/security/netpol-database.yaml
done
```

Verify after applying (app should still connect; a pod in another namespace
should not):

```bash
kubectl -n staging get netpol
# from an app pod — should succeed:
kubectl -n staging exec deploy/blobscan-api -- \
  sh -c 'nc -z -w3 blobscan-staging-db-cluster-pooler-rw 5432 && echo OK'
```

> NOTE: NetworkPolicies require a CNI that enforces them. DOKS uses Cilium, so
> they are enforced. On a cluster without a policy-enforcing CNI these objects
> are silently inert — confirm enforcement before relying on them.

## 2. Pod Security Standards (namespace labels)

Roll out in non-enforcing mode first, then enforce `baseline` once warnings are
clean. Do **not** enforce `restricted` on namespaces that legitimately need
elevated privileges (the `tailscale` subnet router needs NET_ADMIN + a host
device; cnpg may also need leeway).

Audit/warn everywhere first (non-breaking — surfaces violations only):

```bash
for ns in staging mainnet gnosis sepolia hoodi holesky docs monitoring; do
  kubectl label --overwrite ns "$ns" \
    pod-security.kubernetes.io/warn=restricted \
    pod-security.kubernetes.io/audit=restricted
done
```

Then enforce `baseline` on the app namespaces (blocks the worst — privileged,
hostNetwork, hostPID — without requiring full `restricted` compliance):

```bash
for ns in staging mainnet gnosis sepolia hoodi holesky docs; do
  kubectl label --overwrite ns "$ns" \
    pod-security.kubernetes.io/enforce=baseline
done
```

Leave `tailscale` unlabeled for enforcement (its router is privileged by
design — already minimized to NET_ADMIN + /dev/net/tun, but still not
`baseline`-compliant because of the host device mount):

```bash
# explicit, self-documenting: privileged workload, enforcement exempted
kubectl label --overwrite ns tailscale \
  pod-security.kubernetes.io/enforce=privileged
```

## Rollback

```bash
# NetworkPolicy
kubectl -n <ns> delete netpol db-restrict-ingress
# PSS labels
kubectl label ns <ns> \
  pod-security.kubernetes.io/enforce- \
  pod-security.kubernetes.io/warn- \
  pod-security.kubernetes.io/audit-
```
