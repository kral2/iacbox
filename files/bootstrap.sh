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

## install GitHub cli
dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
dnf install gh -y

# getting latest HashiCorp tooling (Packer, Terraform, Consul, Vault, Nomad)
curl -LO https://raw.github.com/kral2/hashistack-installer/main/hashistack-install.sh
chmod +x hashistack-install.sh
./hashistack-install.sh packer terraform consul vault nomad

# Python tooling
## update setuptools, wheel and pip
dnf install platform-python-devel.aarch64 -y # required by pre-commit
python -m pip install setuptools wheel --upgrade # required by pre-commit
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
python -m pip install pre-commit --upgrade

# install project_o (oci cli helpers)
# https://github.com/oracle/oci-cli/tree/master/scripts/examples/project_o

where=$(which oci) && wget -q https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/examples/project_o/o -O "${where%ci}" && chmod a+x "${where%ci}"

# installing Ansible, collections and roles
python -m pip install ansible # dnf install ansible ansible-doc -y
ansible-galaxy collection install oracle.oci
ansible-galaxy role install cimon-io.systemd-service

# install Go globally
## required to install terraform-docs as there is no pre-build arm64 binaries
## install Go from Golang.org as OL8 currently only distribute Go 1.15
GO_PACKAGE="go1.17.2.linux-arm64.tar.gz"
wget "https://golang.org/dl/$GO_PACKAGE"
rm -rf /usr/local/go && tar -C /usr/local -xzf "$GO_PACKAGE"
echo "PATH=$PATH:/usr/local/go/bin" >> /etc/environment
rm -rf "$GO_PACKAGE"

{
    echo "#!/bin/sh"
    echo "sudo /usr/local/go/bin/go env -w GOBIN=/usr/local/bin"
    echo "sudo /usr/local/go/bin/go install github.com/terraform-docs/terraform-docs@latest"
} >> $HOME_FOLDER/install_terraform_docs.sh

chmod +x $HOME_FOLDER/install_terraform_docs.sh
/bin/su -c "$HOME_FOLDER/install_terraform_docs.sh" - "$SYSTEM_USER"

rm -rf "$HOME_FOLDER/install_terraform_docs.sh"

# install container tools

sudo dnf module install container-tools:ol8 -y
sudo dnf install podman-docker -y
