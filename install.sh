
#!/bin/sh
#install docker and java
echo "Install required packages"
sudo apt-get install -y default-jdk \
apt-transport-https \
ca-certificates \
curl \
wget \
gnupg-agent \
unzip \
software-properties-common -y
echo "Making build agent folder"
mkdir /home/tcagent/buildagent
cd /home/tcagent/buildagent
echo "Adding docker registry"
#Add docker repo
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
#Add docker registry
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

# install .net core
wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
wget https://packages.microsoft.com/config/debian/9/prod.list
sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list
# sdk
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y dotnet-sdk-3.1
#runtime
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y dotnet-runtime-3.1

# update registries
echo "Updating after docker registry added"
sudo apt-get update
# install docker
echo "Installing docker"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# get zip
echo "Downloading TC agent installer"
sudo wget $1
echo "Unzipping agent"
unzip /home/tcagent/buildagent/buildAgent.zip -d /home/tcagent/buildagent

echo "Installing tc agent"
cd bin
# install server
sh install.sh $2
# starting and stopping agent to make sure propery file exists
sh agent.sh start
sleep 5
sh agent.sh stop kill

echo "name=$(hostname)" >> /home/tcagent/buildagent/conf/buildAgent.properties

sh agent.sh start
sleep 5
sh agent.sh stop kill
