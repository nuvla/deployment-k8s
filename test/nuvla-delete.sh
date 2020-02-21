#!/bin/bash

kubectl delete -f namespace.yaml
kubectl delete -f traefik-rbac.yaml
