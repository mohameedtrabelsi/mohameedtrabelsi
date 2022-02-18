param (
    [Parameter(Mandatory)][string]$url,
    [Parameter(Mandatory)][string]$pat,
    [Parameter(Mandatory)][string]$pool
)

# $URL = 'https://dev.azure.com/allymeer-hossen/'
# $PAT = 'pizo3qutl3xon7rppur7kxuuj6kbfin5fc7cxhu6exhdailn6hwq'
# $POOL = 'test'
$agent = Hostname

#test if an old installation exists, if so, delete the folder
if (test-path "c:\agent")
{
    Remove-Item -Path "c:\agent" -Force -Confirm:$false -Recurse
}

#create a new folder
new-item -ItemType Directory -Force -Path "c:\agent"
set-location "c:\agent"
$env:VSTS_AGENT_HTTPTRACE = $true

#github requires tls 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#get the latest build agent version
$wr = Invoke-WebRequest https://api.github.com/repos/Microsoft/azure-pipelines-agent/releases/latest -UseBasicParsing
$tag = ($wr | ConvertFrom-Json)[0].tag_name
$tag = $tag.Substring(1)

#build the url
$download = "https://vstsagentpackage.azureedge.net/agent/$tag/vsts-agent-win-x64-$tag.zip"
#download the agent
Invoke-WebRequest $download -Out vsts-agent.zip

#expand the zip
Expand-Archive -Path vsts-agent.zip -DestinationPath $PWD

#run the config script of the build agent
.\config.cmd --unattended --url "$url" --auth pat --token "$pat" --pool "$pool" --agent "$agent" --acceptTeeEula --runAsService

#exit
#Stop-Transcript
#exit 0
###############
###TERRAFORM###
################
$SaveToPath = 'C:\Terraform'

try
{
    if ($PSCmdlet.ParameterSetName -eq 'Version')
    {
        $downloadVersion = $Version
    }
    else
    {
        $releasesUrl = 'https://api.github.com/repos/hashicorp/terraform/releases'
        $releases = Invoke-RestMethod -Method Get -UseBasicParsing -Uri $releasesUrl
        $downloadVersion = $releases.Where({!$_.prerelease})[0].name.trim('v')
    }

    $terraformFile = "terraform_${downloadVersion}_windows_amd64.zip"
    $terraformURL = "https://releases.hashicorp.com/terraform/${downloadVersion}/${terraformFile}"

    $download = Invoke-WebRequest -UseBasicParsing -Uri $terraformURL -DisableKeepAlive -OutFile "${env:Temp}\${terraformFile}" -ErrorAction SilentlyContinue -PassThru

    if (($download.StatusCode -eq 200) -and (Test-Path "${env:Temp}\${terraformFile}"))
    {
        # If SaveToPath does not exist, create it
        if (-not (Test-Path -Path $SaveToPath))
        {
            $null = New-Item -Path $SaveToPath -ItemType Directory -Force
        }

        # Unblock File
        Unblock-File "${env:Temp}\${terraformFile}"

        # Unpack archive
        Start-Sleep -Seconds 10
        Expand-Archive -Path "${env:Temp}\${terraformFile}" -DestinationPath $SaveToPath -Force

        # Clean up temp folder
        Remove-Item -Path "${env:Temp}\${terraformFile}" -Force

        # Set up environment variable
        
        $path = [Environment]::GetEnvironmentVariable('Path', "Machine")
        [Environment]::SetEnvironmentVariable('PATH', "${path};${SaveToPath}", 'Machine')

    }
}
catch
{
    Write-Error $_
}
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
##################
##BICEP INSTALL###
##################
# Create the install folder
$installPath = "$env:USERPROFILE\.bicep"
$installDir = New-Item -ItemType Directory -Path $installPath -Force
$installDir.Attributes += 'Hidden'
# Fetch the latest Bicep CLI binary
(New-Object Net.WebClient).DownloadFile("https://github.com/Azure/bicep/releases/latest/download/bicep-win-x64.exe", "$installPath\bicep.exe")
# Add bicep to your PATH
$currentPath = (Get-Item -path "HKCU:\Environment" ).GetValue('Path', '', 'DoNotExpandEnvironmentNames')
if (-not $currentPath.Contains("%USERPROFILE%\.bicep")) { setx PATH ($currentPath + ";%USERPROFILE%\.bicep") }
if (-not $env:path.Contains($installPath)) { $env:path += ";$installPath" }
# Verify you can now access the 'bicep' command.
bicep --help
# Done! ##########################################
#####Disable IE security on Windows Server via PowerShell
function Disable-InternetExplorerESC {
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force
    Stop-Process -Name Explorer -Force
    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green
}
function Enable-InternetExplorerESC {
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 1 -Force
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 1 -Force
    Stop-Process -Name Explorer
    Write-Host "IE Enhanced Security Configuration (ESC) has been enabled." -ForegroundColor Green
}
function Disable-UserAccessControl {
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000 -Force
    Write-Host "User Access Control (UAC) has been disabled." -ForegroundColor Green    
}
Disable-UserAccessControl
Disable-InternetExplorerESC

#####GIT INSTALL############################
# get latest download url for git-for-windows 64-bit exe
$git_url = "https://api.github.com/repos/git-for-windows/git/releases/latest"
$asset = Invoke-RestMethod -Method Get -Uri $git_url | % assets | where name -like "*64-bit.exe"
# download installer
$installer = "$env:temp\$($asset.name)"
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $installer
# run installer
$git_install_inf = "<install inf file>"
$install_args = "/SP- /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL /NORESTART /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /LOADINF=""$git_install_inf"""
Start-Process -FilePath $installer -ArgumentList $install_args -Wait
$env:Path += ";C:\Program Files\Git\bin"
