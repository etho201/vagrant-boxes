#!/bin/bash

spacewalk-common-channels -v -u admin -p Password1 -a x86_64 -k unlimited 'oraclelinux7*'
spacewalk-common-channels -v -u admin -p Password1 -a x86_64 -k unlimited 'oraclelinux8*'

mkdir ~/.spacecmd
echo '[spacecmd]
username=admin
password=Password1' > ~/.spacecmd/config
chmod 400 ~/.spacecmd/config

spacecmd -- softwarechannel_create -l oraclelinux7-x86_64-ksplice -n "Ksplice for Oracle Linux 7 (x86_64)" -p oraclelinux7-x86_64 -a x86_64
spacecmd -- repo_create -n "External - Ksplice for Oracle Linux 7 (x86_64)" -u "uln:///ol7_x86_64_ksplice" -t uln
spacecmd -- softwarechannel_addrepo oraclelinux7-x86_64-ksplice "External - Ksplice for Oracle Linux 7 (x86_64)"

spacecmd -- softwarechannel_create -l oraclelinux8-x86_64-ksplice -n "Ksplice for Oracle Linux 8 (x86_64)" -p oraclelinux8-x86_64 -a x86_64
spacecmd -- repo_create -n "External - Ksplice for Oracle Linux 8 (x86_64)" -u "uln:///ol8_x86_64_ksplice" -t uln
spacecmd -- softwarechannel_addrepo oraclelinux8-x86_64-ksplice "External - Ksplice for Oracle Linux 8 (x86_64)"

# Register the Spacewalk server as a client to itself
yum install rhn-client-tools rhn-check rhn-setup rhnsd m2crypto yum-rhn-plugin -y
rhnreg_ks --sslCACert=/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT --serverUrl=http://192.168.56.10/XMLRPC --activationkey=1-oraclelinux7-x86_64