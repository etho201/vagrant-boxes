# Install and configure VNC Server:

```bash
sudo dnf install -y tigervnc-server tigervnc-server-module

vncpasswd

restorecon -RFv $HOME/.vnc

sudo su
echo ":1=vagrant" >> /etc/tigervnc/vncserver.users

mkdir -p /etc/systemd/system/vncserver@.service.d/
cat <<EOF > /etc/systemd/system/vncserver@.service.d/10-restart.conf
[Service]
Restart=always
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now vncserver@:1.service


sudo firewall-cmd --zone=public --add-service=vnc-server --permanent
sudo firewall-cmd --reload

```

> Source: https://docs.oracle.com/en/learn/install-vnc-oracle-linux/index.html