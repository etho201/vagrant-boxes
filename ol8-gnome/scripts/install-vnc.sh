# Install the VNC packages
dnf install -y tigervnc-server tigervnc-server-module

# Set VNC password
vncpasswd="vagrant"
mkdir /home/vagrant/.vnc
echo $vncpasswd | vncpasswd -f > /home/vagrant/.vnc/passwd
chown -R vagrant:vagrant /home/vagrant/.vnc
chmod 0600 /home/vagrant/.vnc/passwd
restorecon -RFv /home/vagrant/.vnc

# Configure the VNC service
echo ":1=vagrant" >> /etc/tigervnc/vncserver.users
mkdir -p /etc/systemd/system/vncserver@.service.d/
cat <<EOF > /etc/systemd/system/vncserver@.service.d/10-restart.conf
[Service]
Restart=always
EOF

# Set up the VNC service
systemctl daemon-reload
systemctl enable --now vncserver@:1.service

# Configure firewall rules
firewall-cmd --zone=public --add-service=vnc-server --permanent
firewall-cmd --reload