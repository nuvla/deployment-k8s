# Nuvla deployment on Kubernetes cluster

This folder contains a test deployment of Nuvla that uses `emptyDir` K8s volume.

NB! All the data stored by the persistence layer of Nuvla (Elasticsearch and
Zookeeper) will be deleted as soon as at least one of the corresponding `Pod`,
`ReplicaSet` or `Deployment` objects are deleted.

## Quick deploy / terminate

***Deploy***

Have a K8s cluster with the kubectl context pointing to it. 

Run the following to deploy

    ./nuvla-deploy.sh

To get the port number on which the Nuvla is running on the deployed K8s cluster
run the following

    PORT=$(kubectl -n nuvla-test get service/traefik-ingress-service -o json | \
       jq '.spec.ports[] | select(.name == "https") | .nodePort')

After the deployment, the Nuvla service is running on `https://<k8s external ip>:$PORT`.

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

