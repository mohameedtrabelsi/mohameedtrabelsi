echo "$1" > /tmp/echofile
echo "$2" > /tmp/echofile2
echo "$3" > /tmp/echofile3
sudo mkdir /myagent
cd /myagent
sudo wget https://vstsagentpackage.azureedge.net/agent/2.186.1/vsts-agent-linux-x64-2.186.1.tar.gz
sudo tar zxvf ./vsts-agent-linux-x64-2.186.1.tar.gz
sudo chmod -R 777 /myagent
runuser -l azureuser -c "/myagent/config.sh --unattended  --url $1 --auth pat --token $2 --pool $3"
#/myagent/config.sh --unattended  --url "$1" --auth pat --token "$2" --pool "$3"
sudo /myagent/svc.sh install
sudo /myagent/svc.sh start
exit 0
