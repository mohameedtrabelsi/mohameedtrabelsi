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
Stop-Transcript
exit 0
#####TERRAFORM
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


