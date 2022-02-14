# Helm chart for Apache Kafka Strimzi Operator

Helm chart for deployment of the Apache Kafka Strimzi Operator for Kubernetes.

*NB!* This chart must be deployed before `kafka-strimzi-deployment` helm chart.

## Package and upload

```shell script
helm install -n nuvla-kafka --create-namespace -f values.yaml strimzi-kafka-operator strimzi/strimzi-kafka-operator
```
