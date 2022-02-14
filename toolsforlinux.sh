#Terraform
sudo wget https://releases.hashicorp.com/terraform/1.1.5/terraform_1.1.5_linux_amd64.zip
sudo apt install unzip && unzip terraform_1.1.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/
#GIT
sudo apt install git-all -y
##Install CLI on Linux###
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
#Agentdevops
#echo "$1" > /tmp/echofile
#echo "$2" > /tmp/echofile2
#echo "$3" > /tmp/echofile3
sudo mkdir /myagent
cd /myagent
sudo wget https://vstsagentpackage.azureedge.net/agent/2.186.1/vsts-agent-linux-x64-2.186.1.tar.gz
sudo tar zxvf ./vsts-agent-linux-x64-2.186.1.tar.gz
sudo chmod -R 777 /myagent
runuser -l azureuser -c "/myagent/config.sh --unattended  --url $1 --auth pat --token $2 --pool $3"
#/myagent/config.sh --unattended  --url "$1" --auth pat --token "$2" --pool "$3"
sudo /myagent/svc.sh install
sudo /myagent/svc.sh start
#exit 0
#Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
### update OS & Install PSHELL & Module AZ
cd /home/azureuser
sudo apt-get update
sudo apt-get install -y wget apt-transport-https
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo add-apt-repository universe
sudo apt-get install -y powershell
pwsh -c "Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force"
#pwsh -c Install-Module -Name Az -Force
