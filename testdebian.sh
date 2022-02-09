sudo apt update && sudo apt upgrade
sudo apt install curl
sudo apt install python3-pycurl

# download azdo agent
mkdir $(pwd)/myagent
cd $(pwd)/myagent
wget https://vstsagentpackage.azureedge.net/agent/2.196.2/vsts-agent-linux-x64-2.196.2.tar.gz # Newer versions may be available at the time you're reading this
tar xzvf *.tar.gz
# configure as azdouser
cd ..
chmod -R o+w $(pwd)/myagent
cd $(pwd)/myagent
./config.sh --unattended --url "https://dev.azure.com/allymeer-hossen/" --auth pat --token "lukspdn2imzgatakygjlix4ecypl76z67gytwzf4hd3ush6i24wq" --pool "testing" --agent $(hostname) --runAsService
# install and start the service
sudo ./svc.sh install
sudo ./svc.sh start
sudo ./svc.sh status
