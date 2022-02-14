# Helm chart for Apache Kafka Strimzi Deployment

Helm chart for deployment of the Apache Kafka Strimzi Deployment for Kubernetes.

*NB!* This chart must be deployed after the deployment of the Strimzi Operator from 
`kafka-strimzi-operator` chart. Hence, first deploy `kafka-strimzi-operator`, and 
only then this helm chart.

## Package and upload

Package.

```shell script
helm package .
```

This produces the versioned tarball, e.g.: `kafka-strimzi-deployment-0.0.1.tgz`

Upload the tarball to the Helm repo.

Example:

```shell script
curl -isv -u $USER:$SECRET https://<helm repo URL> --upload-file kafka-strimzi-deployment-0.0.1.tgz
```

## Deployment

### From local repo

Install.

```shell script
helm install -n nuvla-kafka -f values.yaml kafka .
```

Uninstall.

```shell script
helm uninstall -n nuvla-kafka kafka
```

### From Helm repo

Add Helm repo.

```shell script
helm repo add nuvla-helm https://<helm repo URL> --username $USER --password $SECRET
```

Fetch chart.

```shell script
helm fetch nuvla-helm/kafka-strimzi-deployment
```

Install chart.

```shell script
helm install -n nuvla-kafka kafka kafka-strimzi-deployment-0.0.1.tgz
```
