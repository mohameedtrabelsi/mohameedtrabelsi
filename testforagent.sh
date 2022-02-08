wget https://vstsagentpackage.azureedge.net/agent/2.195.1/vsts-agent-linux-x64-2.195.1.tar.gz
# Create directory and navigate to the directory
mkdir agent
cd agent
# Extract the downloaded zip file
tar zxf ~/Downloads/vsts-agent-linux-x64-2.195.1.tar.gz
# Verify the extraction
ls
./config.sh
