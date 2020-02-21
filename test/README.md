# Nuvla deployment on Kubernetes cluster

This folder contains a test deployment of Nuvla that uses `emptyDir` K8s volume.

NB! All the data stored by the persistence layer of Nuvla (Elasticsearch and
Zookeeper) will be lost as soon as at least one of the corresponding `Pod`,
`ReplicaSet` or `Deployment` objects is deleted.

## Quick deploy / terminate

***Deploy***

You must have a Kubernetes cluster with the `kubectl` context pointing to it. If
you don't have one, referer to `k8s-cluster` folder at the root of the project
to provision one.

Run the following to deploy

    ./nuvla-deploy.sh

The deployment in done into `nuvla-test` namespace. 

Give the deployment ~3 minutes. Check if all the Pods are in Running state

    $ kubectl -n nuvla-test get pod
    NAME                                          READY   STATUS    RESTARTS   AGE
    api-6499d4d4c-dx7tn                           1/1     Running   0          2m56s
    es-5bb78547c4-bjpk7                           1/1     Running   0          2m57s
    job-executor-69d96b9f4b-k9c27                 1/1     Running   0          2m56s
    jobd-comp-image-state-7cb7bd74db-h6kht        1/1     Running   4          2m56s
    jobd-deployment-state-7bdc9f77bc-c74qc        1/1     Running   4          2m56s
    jobd-jobs-cleanup-6f66675549-xd4f2            1/1     Running   0          2m56s
    jobd-srvc-image-state-7b5c4b5778-vgkgn        1/1     Running   4          2m56s
    traefik-ingress-controller-5798b5646f-hgzp7   1/1     Running   0          2m54s
    ui-584b85c6f6-d45jz                           1/1     Running   0          2m56s
    zk-747cfcdb99-dls55                           1/1     Running   0          2m57s
    $ 


To get the port number on which the Nuvla is running on the deployed K8s cluster
run the following

    kubectl -n nuvla-test get service/traefik-ingress-service -o json | \
       jq '.spec.ports[] | select(.name == "https") | .nodePort'

After the deployment, the Nuvla service is running on `https://<k8s external ip>:<https ingress>`.

***Terminate***

Run the following to terminate the deployment

    ./nuvla-delete.sh

The detailed description on the deployment steps performed by the script follows
below.

## Deployment step-by-step

### Nuvla namespace

The deployment is preformed into `nuvla-test` namespace.

    kubectl create -f namespace.yaml

### Deploy Zookeeper

    kubectl -n nuvla-test create -f zk-deployment.yaml

### Deploy Elasticsearch

    kubectl -n nuvla-test create -f es-deployment.yaml

### Deploy Nuvla API

    kubectl -n nuvla-test create -f api-deployment.yaml

### Deploy jobs distributors and executors

All job distributors and executors are defined in a single deployment file.

    kubectl -n nuvla-test create -f jobs-deployment.yaml

### Deploy UI static content provider

    kubectl -n nuvla-test create -f ui-deployment.yaml

### Deploy Traefik

Nuvla uses Traefik as Ingress controller. For the test deployment we use the
default TLS certificate that comes with Traefik.

    kubectl apply -f traefik-rbac.yaml
    kubectl -n nuvla-test create configmap traefik-conf --from-file=traefik.toml
    kubectl -n nuvla-test apply -f traefik-deployment.yaml
    kubectl -n nuvla-test apply -f traefik-ingress.yaml

## Deployment state

To get the state of the deployment run

    kubectl -n nuvla-test get all

## Termination step-by-step

Deletion of the namespace will delete all the objects from it

    kubectl delete -f namespace.yaml

Delete RBAC rules for the ingress controller

    kubectl delete -f traefik-rbac.yaml

