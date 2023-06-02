#!/bin/bash

export SQUID_NOAUTH_IP=$1

#Deploy K8s Single Node KubeAdm cluster
sudo -i
bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_master.sh)


echo "Remove Taints on master node"
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

echo "Donwload simulation.yaml"
wget https://raw.githubusercontent.com/shashankbarsin/proxy-simulation/main/manifests/simulation.yaml
perl -i -pe "s/<SQUID_NOAUTH_IP>/$(echo -n $SQUID_NOAUTH_IP)/g" simulation.yaml
cp simulation.yaml /home/azureuser/simulation.yaml

echo "Install Calico"
mkdir -p /home/azureuser/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/azureuser/.kube/config
sudo chown azureuser:azureuser /home/azureuser/.kube/config

echo "Install Calico"
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/tigera-operator.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/custom-resources.yaml

sleep 30

echo "Install Utils"
# Install Azure CLI

sudo apt-get update
sudo apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg

curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-get update
sudo apt-get install -y azure-cli

az extension add --name connectedk8s --yes

az extension add --name k8sconfiguration --yes

az extension add --name k8s-extension --yes

cp -R $HOME/.azure /home/azureuser
sudo chown -R azureuser:azureuser /home/azureuser

# Install Helm 3
echo "install helm"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
