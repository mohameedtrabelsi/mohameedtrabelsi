#create installation directory
sudo mkdir $(pwd)/myagent
sudo chmod -R o+w $(pwd)/myagent
cd $(pwd)/myagent
#Download and install the agent
sudo wget https://vstsagentpackage.azureedge.net/agent/2.196.2/vsts-agent-linux-x64-2.196.2.tar.gz
sudo tar zxvf *.tar.gz
cd ..
sudo chmod -R o+w $(pwd)/myagent
cd $(pwd)/myagent
./config.sh --unattended --url "https://dev.azure.com/allymeer-hossen/" --auth PAT --token "lukspdn2imzgatakygjlix4ecypl76z67gytwzf4hd3ush6i24wq" --pool "testing" --agent $(hostname) --runAsService
sudo ./svc.sh install
sudo ./svc.sh start
sudo ./svc.sh status
