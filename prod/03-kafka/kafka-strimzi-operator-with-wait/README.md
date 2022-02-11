# Helm chart for Apache Kafka Strimzi Operator

Helm chart for deployment of the Apache Kafka Strimzi Operator for Kubernetes.

*NB!* This chart must be deployed before `kafka-strimzi-deployment` helm chart.

## Package and upload

```shell script
helm install -n kafka strimzi-kafka-operator strimzi/strimzi-kafka-operator
```

Package.

```shell script
helm package .
```

This produces the versioned tarball, e.g.: `kafka-strimzi-opeartor-0.0.1.tgz`

Upload the tarball to the Helm repo.

Example:

```shell script
curl -isv -u $USER:$SECRET https://<helm repo URL> --upload-file kafka-strimzi-opeartor-0.0.1.tgz
```

## Deployment

### Namespace

Create namespace

```
kubectl create ns nuvla-kafka
```

### From local repo

Install.

```shell script
helm install -n nuvla-kafka kafka-strimzi-operator .
```

Uninstall.

```shell script
helm uninstall -n nuvla-kafka kafka-strimzi-operator
```

### From Helm repo

Add Helm repo.

```shell script
helm repo add nuvla-helm https://<helm repo URL> --username $USER --password $SECRET 
```

Fetch chart.

```shell script
helm fetch nuvla-helm/kafka-strimzi-opeartor
```

Install chart.

```shell script
helm install -n nuvla-kafka kafka-strimzi-operator kafka-strimzi-opeartor-0.0.1.tgz
```
