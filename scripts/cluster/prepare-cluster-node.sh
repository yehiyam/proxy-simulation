# master
sudo -i
bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_master.sh)


echo "Remove Taints on master node"
kubectl taint nodes --all node-role.kubernetes.io/control-plane-



wget https://raw.githubusercontent.com/shashankbarsin/proxy-simulation/main/manifests/simulation.yaml

perl -i -pe "s/<SQUID_NOAUTH_IP>/$(echo -n $SQUID_NOAUTH_IP)/g" simulation.yaml

cp simulation.yaml /home/azureuser/simulation.yaml
