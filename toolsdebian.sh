#GIT
sudo apt update
sudo apt install git
##Install CLI on Linux###
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
#PSHELL
sudo wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt install powershell
#Terraform
wget https://releases.hashicorp.com/terraform/1.1.5/terraform_1.1.5_linux_amd64.zip
sudo apt install unzip && unzip terraform_1.1.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/
