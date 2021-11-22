#!/bin/bash

#####################################################
#                                                   #
#  Description : Install MariaDB from APT           #
#  Author      : Unixx.io                           #
#  E-mail      : github@unixx.io                    #
#  GitHub      : https://www.github.com/unixxio     #
#  Last Update : November 22, 2021                  #
#                                                   #
#####################################################
clear

# Variables
distro="$(lsb_release -sd | awk '{print tolower ($1)}')"
release="$(lsb_release -sc)"
version="$(lsb_release -sr)"
kernel="$(uname -r)"
uptime="$(uptime -p | cut -d " " -f2-)"

packages="curl software-properties-common dirmngr"

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Show the current distribution and version
echo -e "\nDistribution : ${distro}"
echo -e "Release      : ${release}"
echo -e "Version      : ${version}"
echo -e "Kernel       : ${kernel}"
echo -e "Uptime       : ${uptime}"

# Script feedback
echo -e "\nInstalling required packages and MariaDB. Please wait...\n"

# Update packages
apt-get update > /dev/null 2>&1 && apt-get upgrade -y > /dev/null 2>&1

# Install MariaDB
apt-get install mariadb-server mariadb-client -y > /dev/null 2>&1

# Start and enable services
systemctl start mariadb > /dev/null 2>&1
systemctl enable mariadb > /dev/null 2>&1

# Run secure installation to configure password
mysql_secure_installation

# Create file with credentials
echo -e "\nPlease enter the root password for MariaDB"
echo -e -n "Password : "
read root_password

# Create file with credentials
tee /root/.my.cnf <<EOF > /dev/null 2>&1
[client]
user = root
password = ${root_password}
EOF

# End script
echo -e "\nMariaDB is now successfully installed. Enjoy! ;-)\n"
exit 0
