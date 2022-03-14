#Terraform
sudo wget https://releases.hashicorp.com/terraform/1.1.5/terraform_1.1.5_linux_amd64.zip
sudo apt install unzip && unzip terraform_1.1.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/terraform
sudo chmod -R 777 /usr/local/bin/terraform
#GIT
sudo apt install git-all -y
#Agentdevops

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
##Install CLI on Linux###
#curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
sudo apt-get update
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
curl -sL https://packages.microsoft.com/keys/microsoft.asc |
gpg --dearmor |
sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-get update
sudo apt-get install azure-cli
### update OS & Install PSHELL & Module AZ
cd /home/azureuser
sudo apt-get update
runuser -l azureuser sudo apt-get install -y wget apt-transport-https

#### INSTALL AZ Module###
# Download the GNU Privacy Guard (GnuPG or GPG) keys
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
# Register the GPG keys from the Microsoft repository
sudo dpkg -i packages-microsoft-prod.deb
 
# Routine update of packages
sudo apt-get update
 
# Now, enable the "universe" repos
sudo add-apt-repository universe
 
# Install PowerShell Core
sudo apt-get install -y powershell


# Routine upgrade of package
sudo apt-get upgrade powershell
wget https://raw.githubusercontent.com/GithubVictrix/Victrix/main/Powershell.sh
sudo chmod 777 Powershell.sh 
runuser -l azureuser -c "/home/azureuser/Powershell.sh"
