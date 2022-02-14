## Deployment of Nuvla service on Kubernetes

This folder contains deployment of Nuvla service. 

The deployment is done on Kubernetes cluster via Helm chart.
 
The deployment assumes Elasticsearch, Zookeeper, and Kafka are already deployed,
and provided to the chart via parameters (see `values.yaml`).

### Prerequisites

**User session signing certificate**

Generate user session signing certificate and key pair by running

```shell script
./generate-certificates.sh
```  

Check that `session.crt` and `session.key` were created in `secrets/` folder. 

**Mapbox access token**

For Nuvla to show maps, it needs to connect to
the [https://www.mapbox.com/](https://www.mapbox.com/) API. For that, it needs
an API access token. You need to register with service and get the access token
from [https://account.mapbox.com/](https://account.mapbox.com/). The access
token must be set in the `secrets/ui-config.json` under `mapbox-access-token` key.

**Logo URL**

Set the logo URL in `secrets/ui-config.json` under `nuvla-logo-url` to the URL
of the Portal.

### Ingress

[Traefik](https://traefik.io/) is used as the Ingress controller for exposing
Nuvla service and resource routing. The deployment is exposed through the
service of type LoadBalancer. If you can not use LoadBalancer service on the
cloud of your choice (via Kubernetes Cloud Controller Manager), you can
update `traefik.service_type` in `values.yaml` to the NodePort.

### Deployment with Helm

This directory contains the Helm chart to deploy Nuvla service.

To deploy Nuvla service, edit values.yaml and then run

```shell script
helm install -n nuvla-core --create-namespace nuvla .
```

To upgrade run

```shell script
helm -n nuvla-core upgrade nuvla .
```

To delete the deployment run

```shell script
helm uninstall -n nuvla-core nuvla
```
