## Deployment of Nuvla service on Kubernetes

This folder contains deployment of Nuvla service. 

The deployment is done on Kubernetes cluster via Helm chart.

The core of Nuvla depends on three services: 

* Elasticsearch
* Zookeeper    
* Kafka

Those services must be made available before the Nuvla deployment can start.

This repository contains instructions on how to deploy Elasticsearch, Zookeeper,
Kafka, and use their endpoints as parameters for deployment of Nuvla service.

It's possible to use already existing deployments on Elasticsearch, Zookeeper,
and Kafka. Hence, only step 4. from the list below is required to be run.
Otherwise, flow the steps listed below:

1. deploy Elasticsearch following instructions in [01-elasticsearch](01-elasticsearch) folder
2. deploy Zookeeper following instructions in [02-zookeeper](02-zookeeper) folder
3. deploy Kafka following instructions in [03-kafka](03-kafka) folder
4. deploy Nuvla service following instructions in [04-core](04-core) folder. The
   configuration contains defaults for namespaces and port numbers of components
   from 1.-3. If you happened to change any of those or have your own from the
   services deployed elsewhere, collect and use them in the configuration of the
   deployment of the core components of the Nuvla service.

## Deployment considerations

### Omit deployment of Kafka

It's possible to omit deployment of Kafka if notifications service of Nuvla is
not planned to be used.

To achieve that
1. skip deployment defined in [03-kafka](03-kafka),
2. in [04-core/values.yaml](04-core/values.yaml) set 
   `KAFKA_PRODUCER_INIT` to `no`.

### Persistence

By default, deployments of Elasticsearch, Zookeeper, and Kafka use `longhorn` as
storage class. The value can be updated in the corresponding `values.yaml` files
of the deployments to match your environment.
 
## Capacity planning

For the deployment, consider three nodes cluster with 4CPU, 8GB RAM, and 100GB
disk space on each node.

### Elasticsearch

Typical requirements with a moderate load on the service are

```yaml
          resources:
            requests:
              cpu: "750m"
              memory: "2Gi"
            limits:
              cpu: "1000m"
              memory: "2.5Gi"
```

In these conditions, the service is started with `Xms2g` and `Xmx2g`.

For details see [es-deployment.yaml](01-elasticsearch/templates/es-deployment.yaml).

### Zookeeper

There are no strict requirements.

### Kafka

By default, 
1. deployed with three replicas for Kafka and Zookeeper and,
2. requests PV of 20GB for Kafka and 5GB for Zookeeper.

See [03-kafka/kafka-strimzi-deployment/templates/kafka-deployment.yaml](03-kafka/kafka-strimzi-deployment/templates/kafka-deployment.yaml).

### Nuvla core

**API server** 

Nuvla API server is a stateless service. It's possible to run more than one instance
of it by setting `api.replicas` in [04-core/values.yaml](04-core/values.yaml).
The default is 1 replica.

The minimal requirements of a single instance are as follows and can be updated
in [04-core/templates/api-deployment.yaml](04-core/templates/api-deployment.yaml).

```yaml
         resources:
            requests:
               cpu: "500m"
               memory: "2Gi"
            limits:
               cpu: "750m"
               memory: "2.5Gi"
```

**Jobs service***

Nuvla internal jobs' service is a stateless service. It's possible to run more
than one instance of it by setting `job.replicas_distributor`
and `job.replicas_executor` in [04-core/values.yaml](04-core/values.yaml). The 
default is 1 and 2 replicas correspondingly.

The minimal requirements of a single instance are as follows and can be updated
in [04-core/templates/jobs-deployment.yaml](04-core/templates/jobs-deployment.yaml).

```yaml
          resources:
            requests:
              cpu: "300m"
              memory: "100Mi"
            limits:
              cpu: "500m"
              memory: "200Mi"
```

**UI service**

Nuvla UI service is a stateless service. It's possible to run more than one
instance of it by setting `ui.replicas` [04-core/values.yaml](04-core/values.yaml). 
The default is 1.

The minimal requirements of a single instance are as follows and can be updated
in [04-core/templates/ui-deployment.yaml](04-core/templates/ui-deployment.yaml).

```yaml
         resources:
            requests:
               cpu: "100m"
               memory: "50Mi"
            limits:
               cpu: "200m"
               memory: "100Mi"
```
