# Nuvla deployment on Kubernetes cluster

There is a number of prerequisites before you can deploy Nuvla from the
definitions provided in this folder.
 
## Prerequisites

### Kubernetes cluster

First, you need a working Kubernetes cluster (preferably v1.14+). Example of
provisioning of the cluster on Exoscale cloud is provided in `k8s-cluster`
folder at the root of this project. It uses `docker-machine` and can be updated
to deploy on other clouds supported by `docker-machine`.

### Persistent Volumes

Second, the definitions of the persistence layer of Nuvla here assume that the
following Persistent Volumes (PV) are present

* `zk-data` and `zk-datalog` for Zookeeper, and 
* `es-data` for Elasticsearch.

The PVs should have `ReadWriteOnce` access mode, and `Retain` as `reclaimPolicy`
(which is a default for example for static volumes on CephFS).

`zk-deployment.yaml` and `es-deployment.yaml` are defining persistent volume
claims (PVC) against the PVs above.

An example of static PVs defined on CephFS (on Ceph provisioned by Rook) can be
found in `cephfs` sub-folder.

## Nuvla namespace

Everything is deployed into `nuvla` namespace defined in `namespace.yaml`.

    kubectl create -f namespace.yaml

## Create PVs

Check `Persistent Volumes` section above. 

## Deploy Zookeeper

    kubectl -n nuvla create -f zk-deployment.yaml

## Deploy Elasticsearch

Create `/var/tmp/es-data` with on the cluster or update path in `hostPath` in
`es-deployment.yaml` to point to different existing folder on the cluster. 

    kubectl -n nuvla create -f es-deployment.yaml

## Deploy Nuvla API

    kubectl -n nuvla create -f api-deployment.yaml

## Deploy jobs distributors and executors

All job distributors and executors are defined in a single deployment file.

    kubectl -n nuvla create -f jobs-deployment.yaml

## Deploy UI static content provider

    kubectl -n nuvla create -f ui-deployment.yaml

## Deploy Traefik

Nuvla uses Traefik as Ingress controller.

Create or provide existing TLS certs and Secret with Traefik TLS certs. Below
self-signed certificate is used. If proper authentication is required, please
use certificates provided by your trusted CA.

    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=test.nuvla"
    kubectl -n nuvla create secret tls traefik-tls-cert --key=tls.key --cert=tls.crt

Create ConfigMap with Traefik config

    kubectl -n nuvla create configmap traefik-conf --from-file=traefik.toml

Deploy Traefik

    kubectl -n nuvla apply -f traefik-rbac.yaml
    kubectl -n nuvla apply -f traefik-deployment.yaml
    kubectl -n nuvla apply -f traefik-ingress.yaml

When working with Kubernetes cluster v1.13 or lower, creation of `Ingress` will
fail. Update `traefik-ingress.yaml` to use `apiVersion: extensions/v1beta1`. 
See https://github.com/kubernetes/website/issues/14559#issuecomment-496988496

