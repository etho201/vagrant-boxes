#!/bin/bash

dnf install oracle-linux-manager-client-release-el8 -y

dnf -y module disable rhn-tools satellite-5-client
dnf -y --allowerasing install python3-rhnlib python3-spacewalk-usix rhn-client-tools rhn-check rhn-setup rhnsd dnf-plugin-spacewalk
dnf -y remove rhnlib

wget -q -O /usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT http://${OLM_HOSTNAME}/pub/RHN-ORG-TRUSTED-SSL-CERT
dnf install http://${OLM_HOSTNAME}/pub/rhn-org-trusted-ssl-cert-1.0-1.noarch.rpm -y
rhnreg_ks --sslCACert=/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT --serverUrl=http://${OLM_HOSTNAME}/XMLRPC --activationkey=1-oraclelinux8-x86_64