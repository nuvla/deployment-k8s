## Deployment of Elasticsearch for Nuvla service 

This folder contains deployment of Elasticsearch for the Nuvla service on
Kubernetes.

The deployment is done on Kubernetes cluster via Helm chart.
 
### Deployment with Helm

Edit values.yaml and run the following command to deploy Elasticsearch for Nuvla
service

```
helm install -n db --create-namespace db .
```

To delete the deployment, run

```
helm uninstall -n db db 
```
