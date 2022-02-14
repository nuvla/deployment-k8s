# Helm chart for Apache Kafka Strimzi Operator

Helm chart for deployment of the Apache Kafka Strimzi Operator for Kubernetes.

*NB!* This chart must be deployed before `kafka-strimzi-deployment` helm chart.

## Package and upload

```shell
helm install -n kafka strimzi-kafka-operator strimzi/strimzi-kafka-operator
```

Package.

```shell
helm package .
```

This produces the versioned tarball, e.g.: `kafka-strimzi-opeartor-0.0.1.tgz`

Upload the tarball to the Helm repo.

Example:

```shell
curl -isv -u $USER:$SECRET https://<helm repo URL> --upload-file kafka-strimzi-opeartor-0.0.1.tgz
```

## Deployment

### From local repo

Install.

```shell
helm install -n nuvla-kafka kafka-strimzi-operator --create-namespace .
```

Uninstall.

```shell
helm uninstall -n nuvla-kafka kafka-strimzi-operator
```

### From Helm repo

Add Helm repo.

```shell
helm repo add nuvla-helm https://<helm repo URL> --username $USER --password $SECRET 
```

Fetch chart.

```shell
helm fetch nuvla-helm/kafka-strimzi-opeartor
```

Install chart.

```shell
helm install -n nuvla-kafka kafka-strimzi-operator kafka-strimzi-opeartor-0.0.1.tgz
```
