#!/bin/bash

dnf install -y oraclelinux-release-el8 oracle-olcne-release-el8 oracle-linux-manager-client-release-el8 oracle-spacewalk-client-release-el8 oracle-gluster-release-el8 oracle-instantclient-release-el8 oracle-release-el8 oraclelinux-developer-release-el8 mysql-release-el8
# oraclelinux-release-el8, oraclelinux-release-el7
# oraclelinux-patchonly-release-el7
# oracle-softwarecollection-release-el7
# oracle-olcne-release-el8, oracle-olcne-release-el7
# oracle-linux-manager-server-release-el7
# oracle-linux-manager-client-release-el8, oracle-linux-manager-client-release-el7
# oracle-spacewalk-server-release-el7
# oracle-spacewalk-client-release-el8, oracle-spacewalk-client-release-el7
# oracle-gluster-release-el8, oracle-gluster-release-el7
# oracle-ceph-release-el7
# oracle-instantclient-release-el8, oracle-instantclient-release-el7
# oracle-release-el8, oracle-release-el7
# oracle-epel-release-el8, oracle-epel-release-el7
# oraclelinux-developer-release-el8, oraclelinux-developer-release-el7
# oracle-graalvm-ce-release-el7
# mysql-release-el8, mysql-release-el7
# oracle-golang-release-el7
# oracle-php-release-el7
# oracle-nodejs-release-el7

dnf makecache
dnf -C list all > /data/yum-packages.txt
