cd /home/azureuser
sudo apt-get update
sudo apt-get install -y wget apt-transport-https
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo add-apt-repository universe
sudo apt-get install -y powershell
pwsh -c Install-Module -Name Az -Force
