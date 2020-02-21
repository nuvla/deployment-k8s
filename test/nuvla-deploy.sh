#!/bin/bash

set -e

kubectl create -f namespace.yaml

kubectl -n nuvla-test create -f zk-deployment.yaml

kubectl -n nuvla-test create -f es-deployment.yaml

kubectl -n nuvla-test create -f api-deployment.yaml

kubectl -n nuvla-test create -f jobs-deployment.yaml

kubectl -n nuvla-test create -f ui-deployment.yaml

kubectl create -f traefik-rbac.yaml
kubectl -n nuvla-test create configmap traefik-conf --from-file=traefik.toml
kubectl -n nuvla-test create -f traefik-deployment.yaml
kubectl -n nuvla-test create -f traefik-ingress.yaml
