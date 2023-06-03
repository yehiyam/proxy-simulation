 
#######################################
echo "Deploy Squid Proxy Server"
#########################################
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install squid
cat ./squid-noauth.conf | sudo tee /etc/squid/squid.conf
sudo systemctl restart squid.service