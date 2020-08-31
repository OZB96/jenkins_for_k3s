#!/bin/bash
POD=$(k3s kubectl get pods -n jenkins -o json | jq '.items[1].metadata.name' | xargs)
echo "Jenkins credentials"
while [[ "$(k3s kubectl -n jenkins --container jenkins exec $POD -- env | grep ADMIN_USER | sed 's/.*=//')" == "" ]] ; do
sleep 2;
POD=$(k3s kubectl get pods -n jenkins -o json | jq '.items[1].metadata.name' | xargs)
done

echo username: $(k3s kubectl -n jenkins --container jenkins exec $POD -- env | grep ADMIN_USER | sed 's/.*=//')
echo password: $(k3s kubectl -n jenkins --container jenkins exec $POD -- env | grep ADMIN_PASSWORD | sed 's/.*=//')
echo port: $(k3s kubectl get service jenkins -n jenkins -o json | jq '.spec.ports[0].nodePort')

