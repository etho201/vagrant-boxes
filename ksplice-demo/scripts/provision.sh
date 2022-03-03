#!/bin/bash

# Replacement of SSL certificate for ULN
# https://blogs.oracle.com/linux/post/action-required-replacement-of-ssl-certificates-for-the-unbreakable-linux-network
curl https://linux-update.oracle.com/rpms/ULN-CA-CERT.sha2 -o /usr/share/rhn/ULN-CA-CERT

# Subscribe to ULN and install Ksplice Uptrack
ulnreg_ks --username=${USERNAME} --password=${PASSWORD} --csi=${CSI}
uln-channel -u ${USERNAME} -p ${PASSWORD} --enable-yum-server
uln-channel -u ${USERNAME} -p ${PASSWORD} -c ol7_x86_64_ksplice -a
yum install -y uptrack

# Install Ansible
# OL8:
# yum install -y oraclelinux-automation-manager-release-el8
# yum install -y ansible
# OL7:
yum install -y oracle-epel-release-el7
yum install -y --enablerepo=ol7_developer_EPEL ansible-python3
