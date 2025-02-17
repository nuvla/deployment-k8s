# Demo deployment of Nuvla on Kubernetes

This folder contains Helm chart for deployment of a demo Nuvla instance.

**NB!** The deployment uses `emptyDir` Kubernetes volume type for all stateful
instances. Hence, all the data stored by the persistence layer of Nuvla
(Elasticsearch and Zookeeper) will be lost as soon as at least one of the
corresponding `Pod`, `ReplicaSet` or `Deployment` objects gets deleted.

## Kubernetes version

`>=1.29.1`

## Deployment with Helm

### From Helm repo

Add Helm repo

```shell script
helm repo add nuvla https://nuvla.github.io/deployment-k8s
```

Deploy latest Nuvla demo version as `nuvla-demo` from the added `nuvla` Helm repository.

```shell script
helm install -n nuvla-demo --create-namespace nuvla-demo nuvla/nuvla-demo
```

### From local chart

Alternatively, deploy from the chart available locally.

`helm-chart/` contains the Helm chart to deploy Nuvla using:

```shell script
helm install -n nuvla-demo --create-namespace nuvla-demo ./helm-chart 
```

## Connecting to deployed Nuvla instance

To get the URL of deployed Nuvla instance, check the output of the `helm
install` and run the commands it suggests. When connected to the portal, use
`super` as username. The corresponding password can be found in values.yaml
under `api.super_password`.

## Uninstalling

To uninstall the release, run

```shell script
helm uninstall -n nuvla-demo nuvla-demo
```
