wget https://releases.hashicorp.com/terraform/1.1.4/terraform_1.1.4_linux_amd64.zip
sudo apt install unzip && unzip terraform_1.1.4_linux_amd64.zip
sudo mv terraform /usr/local/bin/

#mkdir /opt/terraform
#cd /opt/terraform
#curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
#sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
#sudo apt install terraform




#$ sudo mv terraform /usr/local/bin/
#$ which terraform
#/usr/local/bin/terraform
#curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
