 
#######################################
echo "Deploy Squid Proxy Server"
#########################################
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install squid
sudo cp ./squid-noauth.conf /etc/squid/squid.conf
sudo systemctl restart squid.service