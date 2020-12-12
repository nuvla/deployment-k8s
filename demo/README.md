## Demo deployment of Nulva on Kubernetes


`helm-chart/` contains the Helm chart to deploy Nuvla using:

```
helm install -n nuvla-demo --create-namespace nuvla-demo ./helm-chart 
```

For details on how to deploy using a set of K8s manifests see README in
`manifests/`.
