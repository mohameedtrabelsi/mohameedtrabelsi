#############################################
###Install Azure CLI on Windows###
############################################

$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi


#############################################
###Install the Azure Az PowerShell module###
############################################

#Etape1 : Verify the .NET Framework 4.7.2 or higher is installed

#(Get-ItemProperty -Path 'HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full' -ErrorAction SilentlyContinue).Release -ge 461808

#Etape 2 : PowerShell script execution policy must be set to remote signed
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

#Etape : Installation Module AZ
#Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force


