#!/bin/bash

log() {
    echo "INSTALLER: ${*}" | tee -a /tmp/bootstrap.log
}

log "Configuring the software channels, repositories, GPG keys, and activation keys"
spacewalk-common-channels -v -u admin -p Password1 -a x86_64 -k unlimited 'oraclelinux7*'
spacewalk-common-channels -v -u admin -p Password1 -a x86_64 -k unlimited 'oraclelinux8*'

log "Configuring spacecmd"
mkdir ~/.spacecmd
echo '[spacecmd]
username=admin
password=Password1' > ~/.spacecmd/config
chmod 400 ~/.spacecmd/config

log "Adding channels and repositories for Ksplice"
spacecmd -- softwarechannel_create -l ol7_x86_64_ksplice -n "Ksplice for Oracle Linux 7 (x86_64)" -p oraclelinux7-x86_64 -a x86_64
spacecmd -- repo_create -n "External - Ksplice for Oracle Linux 7 (x86_64)" -u "uln:///ol7_x86_64_ksplice" -t uln
spacecmd -- softwarechannel_addrepo ol7_x86_64_ksplice "External - Ksplice for Oracle Linux 7 (x86_64)"
spacecmd -- activationkey_addchildchannels 1-oraclelinux7-x86_64 ol7_x86_64_ksplice

spacecmd -- softwarechannel_create -l ol7_x86_64_userspace_ksplice -n "Ksplice-aware user space packages for Oracle Linux 7 (x86_64)" -p oraclelinux7-x86_64 -a x86_64
spacecmd -- repo_create -n "External - Ksplice-aware user space packages for Oracle Linux 7 (x86_64)" -u "uln:///ol7_x86_64_userspace_ksplice" -t uln
spacecmd -- softwarechannel_addrepo ol7_x86_64_userspace_ksplice "External - Ksplice-aware user space packages for Oracle Linux 7 (x86_64)"
spacecmd -- activationkey_addchildchannels 1-oraclelinux7-x86_64 ol7_x86_64_userspace_ksplice

spacecmd -- softwarechannel_create -l ol8_x86_64_ksplice -n "Ksplice for Oracle Linux 8 (x86_64)" -p oraclelinux8-x86_64 -a x86_64
spacecmd -- repo_create -n "External - Ksplice for Oracle Linux 8 (x86_64)" -u "uln:///ol8_x86_64_ksplice" -t uln
spacecmd -- softwarechannel_addrepo ol8_x86_64_ksplice "External - Ksplice for Oracle Linux 8 (x86_64)"
spacecmd -- activationkey_addchildchannels 1-oraclelinux8-x86_64 ol8_x86_64_ksplice

spacecmd -- softwarechannel_create -l ol8_x86_64_userspace_ksplice -n "Ksplice-aware user space packages for Oracle Linux 8 (x86_64)" -p oraclelinux8-x86_64 -a x86_64
spacecmd -- repo_create -n "External - Ksplice-aware user space packages for Oracle Linux 8 (x86_64)" -u "uln:///ol8_x86_64_userspace_ksplice" -t uln
spacecmd -- softwarechannel_addrepo ol8_x86_64_userspace_ksplice "External - Ksplice-aware user space packages for Oracle Linux 8 (x86_64)"
spacecmd -- activationkey_addchildchannels 1-oraclelinux8-x86_64 ol8_x86_64_userspace_ksplice

log "Register the Spacewalk server as a client to itself"
yum install rhn-client-tools rhn-check rhn-setup rhnsd m2crypto yum-rhn-plugin -y
rhnreg_ks --sslCACert=/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT --serverUrl=http://${OLM_HOSTNAME}/XMLRPC --activationkey=1-oraclelinux7-x86_64