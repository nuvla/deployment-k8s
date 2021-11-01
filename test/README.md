## Deployment of Nuvla on Kubernetes

This folder contains a test deployment of Nuvla. 

The deployment is done on Kubernetes cluster via Helm chart.
 
### Deployment with Helm

This directory contains the Helm chart to deploy Nuvla:

```
helm install -n nuvla --create-namespace nuvla .
```

To delete the deployment run

```
helm uninstall -n nuvla nuvla
```
