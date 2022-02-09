#GIT
apt install build-essential make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
cd /tmp/
wget wget https://github.com/git/git/archive/v2.21.0.zip -O latestgit.zip
unzip latestgit.zip
cd git-2.21.0
sudo make prefix=/usr/local all
sudo make prefix=/usr/local install
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
