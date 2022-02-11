#Terraform
sudo wget https://releases.hashicorp.com/terraform/1.1.5/terraform_1.1.5_linux_amd64.zip
sudo apt install unzip && unzip terraform_1.1.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/
#GIT
sudo apt install build-essential make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
cd /tmp/
sudo wget https://github.com/git/git/archive/v2.21.0.zip -O latestgit.zip
unzip latestgit.zip 
cd git-2.21.0
sudo make prefix=/usr/local all
sudo make prefix=/usr/local install
#Agentdevops
#echo "$1" > /tmp/echofile
#echo "$2" > /tmp/echofile2
#echo "$3" > /tmp/echofile3
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
