#!/bin/bash


sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

mkdir -p /home/azureuser/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/azureuser/.kube/config
sudo chown azureuser:azureuser /home/azureuser/.kube/config

echo "Install Calico"
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/tigera-operator.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/custom-resources.yaml

sleep 30

echo "Remove Taints on master node"
kubectl taint nodes --all node-role.kubernetes.io/master- 
kubectl taint nodes --all node-role.kubernetes.io/control-plane-



wget https://raw.githubusercontent.com/shashankbarsin/proxy-simulation/main/manifests/simulation.yaml

perl -i -pe "s/<SQUID_NOAUTH_IP>/$(echo -n $SQUID_NOAUTH_IP)/g" simulation.yaml

kubectl apply -f simulation.yaml --kubeconfig /etc/kubernetes/admin.conf

