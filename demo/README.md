# Demo deployment of Nulva on Kubernetes

This folder contains a demo deployment of Nuvla that uses `emptyDir` K8s volume.

NB! All the data stored by the persistence layer of Nuvla (Elasticsearch and
Zookeeper) will be lost as soon as at least one of the corresponding `Pod`,
`ReplicaSet` or `Deployment` objects gets deleted.

## Deployment with Helm

### From Helm repo

Add Helm repo

```
helm repo add nuvla https://nuvla.github.io/deployment-k8s
```

Deploy latest Nuvla demo version as `nuvla-demo` from the added `nuvla` Helm repository.

```
helm install -n nuvla-demo --create-namespace nuvla-demo nuvla/nuvla-demo
```

### From local chart

Alternatively, deploy from the chart available locally.

`helm-chart/` contains the Helm chart to deploy Nuvla using:

```
helm install -n nuvla-demo --create-namespace nuvla-demo ./helm-chart 
```
