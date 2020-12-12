#!/bin/bash -x

#set -e

kubectl create -f namespace.yaml

kubectl -n nuvla-demo create -f zk-deployment.yaml

kubectl -n nuvla-demo create -f es-deployment.yaml

kubectl -n nuvla-demo create -f api-deployment.yaml

kubectl -n nuvla-demo create -f jobs-deployment.yaml

kubectl -n nuvla-demo create -f ui-deployment.yaml

kubectl create -f traefik-rbac.yaml
kubectl -n nuvla-demo create configmap traefik-conf --from-file=traefik.toml
kubectl -n nuvla-demo create -f traefik-deployment.yaml
kubectl -n nuvla-demo create -f traefik-ingress.yaml
