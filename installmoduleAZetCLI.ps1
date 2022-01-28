###################################
###Install Azure CLI on Windows###
##################################
#Install Chocolatey so we can simplify the install of some tools and apps for the build agent
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

#Install the Azure CLI
choco install azure-cli -y

#After we install the Azure CLI we need to add to the path environment variable so that az commands will work
$env:Path += ";C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin"

#############################################
###Install the Azure Az PowerShell module###
############################################

#Etape : Installation Module AZ
install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

#Etape : register the default repository for PowerShell modules
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

#Etape : Install the module AZ
Install-Module -Name Az
