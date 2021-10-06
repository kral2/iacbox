#!/bin/sh

# Last update : October, 2021
# Author: cetin.ardal@oracle.com
# Description: Install the necessary tools to start developing Infrastructure as Code solutions on OCI.

script_name=$(basename "$0")
version="0.1.0"
echo "$script_name - version $version"
echo "Installing the necessary tools to start developing Infrastructure as Code solutions on OCI"
echo ""

SYSTEM_USER="opc"
HOME_FOLDER="/home/$SYSTEM_USER"

cd /home/"$SYSTEM_USER"/ || exit

# general system config and tools
yum-config-manager --enable ol8_developer_EPEL
dnf install git -y

# getting latest Terraform and Packer installers from iac.sh
## https://github.com/robertpeteuil/terraform-installer
## https://github.com/robertpeteuil/packer-installer
curl iac.sh/terraform | bash && ./terraform-install.sh -a
curl iac.sh/packer | bash && ./packer-install.sh -a

# installing Ansible, collections and roles
dnf install ansible ansible-doc -y
ansible-galaxy collection install oracle.oci
ansible-galaxy role install cimon-io.systemd-service

# Python tooling
## update pip
python -m pip install pip --upgrade

## install and configure virtualenvwrapper
python -m pip install virtualenvwrapper --upgrade
{
    echo "export WORKON_HOME=$HOME_FOLDER/.virtualenvs"
    echo "export PROJECT_HOME=$HOME_FOLDER/Devel"
    echo "source /usr/local/bin/virtualenvwrapper.sh"
} >> $HOME_FOLDER/.bashrc

## install global packages
python -m pip install oci oci-cli --upgrade
