# Deployment of Zookeeper for Nuvla service

This folder contains deployment of Zookeeper coordination service for Nuvla on
Kubernetes.

The deployment is done on Kubernetes cluster via Helm chart.
 
The deployment uses `emptyDir` K8s volume.

NB! All the data stored by the persistence layer of Nuvla (Elasticsearch and
Zookeeper) will be lost as soon as at least one of the corresponding `Pod`,
`ReplicaSet` or `Deployment` objects gets deleted.

### Deployment with Helm

This directory contains the Helm chart to deploy Zookeeper using:

```
helm install -n nuvla-zk --create-namespace zk .
```

To delete the deployment run

```
helm uninstall -n nuvla-zk zk
```
