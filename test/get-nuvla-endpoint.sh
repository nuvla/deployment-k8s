#!/bin/bash
export NODE_PORT=$(kubectl get -n nuvla -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}' service traefik-ingress-service)
export NODE_IP=$(kubectl get nodes -n {{ .Release.Namespace }} -o jsonpath="{.items[0].status.addresses[0].address}")
echo https://$NODE_IP:$NODE_PORT
