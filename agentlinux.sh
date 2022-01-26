#!/bin/sh

# Creates directory & download ADO agent install files
mkdir myagent && cd myagent
wget https://vstsagentpackage.azureedge.net/agent/2.196.2/vsts-agent-linux-x64-2.196.2.tar.gz
tar zxvf vsts-agent-linux-x64-2.196.2.tar.gz

# Unattended install
./config.sh --unattended \
--agent "${AZP_AGENT_NAME:-$(hostname)}" \
--url "https://dev.azure.com/allymeer-hossen/" \
--auth PAT \
--token "<wzjlas6igiiitg7yrh4fgyehgfeokdy4nyoaqab54xlo32qlgt2a>" \
--pool "testlinux" \
--replace \
--acceptTeeEula & wait $!

cd /home/azureuser/
#Configure as a service
./run.sh install azureuser

#Start svc
./run.sh start
