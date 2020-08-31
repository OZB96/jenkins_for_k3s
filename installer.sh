#!/bin/bash
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update -y
sudo apt-get install helm -y
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
sudo k3s kubectl create serviceaccount --namespace jenkins tiller
sudo k3s kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=jenkins:tiller
sudo k3s kubectl patch deploy --namespace jenkins tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
helm repo add bitnami https://charts.bitnami.com/bitnami
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
helm install jenkins bitnami/jenkins
