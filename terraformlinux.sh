# Debian / Ubuntu systems
sudo apt update
sudo apt install wget curl unzip

# RHEL based systems
sudo yum install curl wget unzip

TER_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip

$ unzip terraform_${TER_VER}_linux_amd64.zip
Archive:  terraform_xxx_linux_amd64.zip
 inflating: terraform

$ sudo mv terraform /usr/local/bin/

$ which terraform
/usr/local/bin/terraform
