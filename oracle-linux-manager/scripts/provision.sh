#!/bin/bash

log() {
    echo "INSTALLER: ${*}" | tee -a /tmp/bootstrap.log
}

log "Remove the jta package if it is installed on the system"
yum remove jta -y
echo "exclude=jta*" >> /etc/yum.conf
yum-config-manager --disable ol7_addons

log "Install the latest oracle-release-el7 package"
yum install oracle-release-el7 -y

log "Resolve issue with 'Delta RPMs disabled because /usr/bin/applydeltarpm not installed'"
yum install deltarpm -y
echo "deltarpm=0" >> /etc/yum.conf

log "Install and enable the Oracle Linux Manager yum repository"
yum install oracle-linux-manager-server-release-el7 -y
yum-config-manager --enable ol7_optional_latest -y

log "Install the following packages for enabling Oracle Linux Manager server to use PostgreSQL"
yum install spacewalk-schema-2.10.14-1.el7 spacewalk-setup-postgresql spacewalk-postgresql spacecmd spacewalk-utils -y

log "Configure Oracle Linux Manager using the answer file"
spacewalk-setup --answer-file=/tmp/answer-file.txt