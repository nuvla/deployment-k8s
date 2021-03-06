## Demo deployment of Nulva on Kubernetes

This folder contains a demo deployment of Nuvla that uses `emptyDir` K8s volume.

NB! All the data stored by the persistence layer of Nuvla (Elasticsearch and
Zookeeper) will be lost as soon as at least one of the corresponding `Pod`,
`ReplicaSet` or `Deployment` objects gets deleted.

### Deployment with Helm

`helm-chart/` contains the Helm chart to deploy Nuvla using:

```
helm install -n nuvla-demo --create-namespace nuvla-demo ./helm-chart 
```

Example of installation from releases

```
helm install -n nuvla-demo --create-namespace nuvla-demo \
    https://github.com/nuvla/deployment-k8s/releases/download/v0.0.1/nuvla-demo-0.0.1.tgz
```

### Deployment as a set of separate K8s manifests

For details on how to deploy using a set of K8s manifests see README in
`manifests/`.
