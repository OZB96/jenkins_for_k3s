#!/bin/bash
k3s kubectl apply -f jenkins.namespace.yaml
k3s kubectl apply -f jenkins.helm.yaml
k3s kubectl -n jenkins apply -f clusterRole.yaml
sleep 60
echo "Making progress"
. query.sh
k3s kubectl -n jenkins apply -f ingress.yaml
