# Test deployment of Nulva on Kubernetes

This folder contains a test deployment of Nuvla that uses `emptyDir` K8s volume.

NB! All the data stored by the persistence layer of Nuvla (Elasticsearch and
Zookeeper) will be lost as soon as at least one of the corresponding `Pod`,
`ReplicaSet` or `Deployment` objects gets deleted.

## Deployment with Helm

This test deployment uses the development version of the Nuvla components.

### From Helm repo

Add Helm repo

```shell script
helm repo add nuvla https://nuvla.github.io/deployment-k8s
```

Deploy latest Nuvla test version as `nuvla-test` from the added `nuvla` Helm repository.

```shell script
helm install --values values.yaml -n nuvla-test --create-namespace nuvla-test nuvla/nuvla-demo
```

### Uninstalling

To uninstall the release, run

```shell script
helm uninstall -n nuvla-demo nuvla-demo
```
