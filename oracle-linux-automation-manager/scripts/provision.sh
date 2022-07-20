#!/bin/bash

# https://docs.oracle.com/en/learn/olam-install/index.html

# Enable the Oracle Linux DNF Repository
dnf config-manager --enable ol8_baseos_latest
dnf install -y oraclelinux-automation-manager-release-el8
dnf config-manager --enable ol8_automation ol8_addons ol8_UEKR6 ol8_appstream

# Install and Configure Oracle Linux Automation Manager
dnf install -y ol-automation-manager
cat <<EOT >> /etc/redis.conf
unixsocket /var/run/redis/redis.sock
unixsocketperm 775
EOT
/var/lib/ol-automation-manager/ol-automation-manager-DB-init.sh
su -l awx -s /bin/bash -c "awx-manage migrate"
su -l awx -s /bin/bash -c "awx-manage createsuperuser --username admin --no-input --email ${EMAIL}"
su -l awx -s /bin/bash -c "awx-manage update_password --username=admin --password=${PASSWORD}"
su -l awx -s /bin/bash -c "awx-manage create_oauth2_token --user=admin" > admin_token
su -l awx -s /bin/bash -c "awx-manage create_preload_data"
su -l awx -s /bin/bash -c "awx-manage provision_instance --hostname=${HOSTNAME}"
su -l awx -s /bin/bash -c "awx-manage register_queue --queuename=tower --hostnames=${HOSTNAME}"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/tower/tower.key -out /etc/tower/tower.crt -subj "/C=US/ST=North Carolina/L=Raleigh/O=Oracle/OU=IT Department/CN=${HOSTNAME}/emailAddress=${EMAIL}"
cp /vagrant/files/nginx.conf /etc/nginx/nginx.conf
sed -i "s/CLUSTER_HOST_ID.*/CLUSTER_HOST_ID = \"${HOSTNAME}\"/g" /etc/tower/settings.py
systemctl enable --now ol-automation-manager.service

# Prepare variables.yml file for Ansible playbook
if [[ $SAMPLE_DEPLOYMENT == true ]]; then
    if [[ -f /vagrant/scripts/variables.yml ]]; then
        mv /vagrant/scripts/variables.yml /vagrant/scripts/variables.yml.backup
    fi
    cp /vagrant/scripts/variables.yml.sample /vagrant/scripts/variables.yml
fi

# Run Ansilble playbook to configure OLAM project
ansible-galaxy collection install -r /vagrant/scripts/collections/requirements.yml -p /vagrant/scripts/collections/
ansible-playbook /vagrant/scripts/configure-project.yml