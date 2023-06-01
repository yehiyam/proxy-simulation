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

