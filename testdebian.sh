#!/bin/sh

# Creates directory & download ADO agent install files

su - azureuser -c "
mkdir myagent && cd myagent
wget https://vstsagentpackage.azureedge.net/agent/2.186.1/vsts-agent-linux-x64-2.186.1.tar.gz
tar zxvf vsts-agent-linux-x64-2.186.1.tar.gz"

# Unattended install

su - azureuser -c "
./config.sh --unattended \
  --agent "${AZP_AGENT_NAME:-$(hostname)}" \
  --url "https://dev.azure.com/allymeer-hossen/" \
  --auth PAT \
  --token "lukspdn2imzgatakygjlix4ecypl76z67gytwzf4hd3ush6i24wq" \
  --pool "testing" \
  --replace \
  --acceptTeeEula & wait $!"

cd /home/azureuser

sudo /myagent/svc.sh install
sudo /myagent/svc.sh start

#Configure as a service
#sudo ./svc.sh install azureuser

#Start svc
#sudo ./svc.sh start
