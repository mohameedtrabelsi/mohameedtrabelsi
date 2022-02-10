##Install CLI on Linux###
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
#Terraform
sudo wget https://releases.hashicorp.com/terraform/1.1.5/terraform_1.1.5_linux_amd64.zip
sudo apt install unzip && unzip terraform_1.1.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/
#agentdevops
sudo mkdir /myagent
cd /myagent
sudo wget https://vstsagentpackage.azureedge.net/agent/2.186.1/vsts-agent-linux-x64-2.186.1.tar.gz
sudo tar zxvf ./vsts-agent-linux-x64-2.186.1.tar.gz
sudo chmod -R 777 /myagent
runuser -l azureuser -c '/myagent/config.sh --unattended  --url "https://dev.azure.com/allymeer-hossen/" --auth pat --token "lukspdn2imzgatakygjlix4ecypl76z67gytwzf4hd3ush6i24wq" --pool "testing"'
sudo /myagent/svc.sh install
sudo /myagent/svc.sh start


#GIT
#sudo apt update && sudo apt upgrade
#sudo apt install curl
#sudo apt install python3-pycurl
#sudo apt install build-essential make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
#cd /tmp/
#sudo wget https://github.com/git/git/archive/v2.21.0.zip -O latestgit.zip
#unzip latestgit.zip 
#cd git-2.21.0
#sudo make prefix=/usr/local all
#sudo make prefix=/usr/local install
##Install CLI on Linux###
#curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
#PSHELL
#sudo wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb
#sudo dpkg -i packages-microsoft-prod.deb
#sudo apt update
#sudo apt install powershell
