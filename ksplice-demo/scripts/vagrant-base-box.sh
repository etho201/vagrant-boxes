# Prepare vagrant user
useradd vagrant
usermod -aG wheel vagrant
echo vagrant:vagrant | chpasswd
echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
echo "Defaults:vagrant !requiretty" >> /etc/sudoers.d/vagrant
mkdir -m 0700 -p /home/vagrant/.ssh
curl https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub >> /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

# Keep SSH speedy even when not connected to the internet
echo "UseDNS no" >> /etc/ssh/sshd_config

# Install packages required for VirtualBox Guest Additions
yum install -y tar bzip2 kernel-uek-devel-$(uname -r) gcc make perl

# Install VirtualBox Guest Additions
mkdir -p /mnt/iso
mount -o loop,ro /root/VBoxGuestAdditions.iso /mnt/iso
/mnt/iso/VBoxLinuxAdditions.run
/sbin/rcvboxadd quicksetup all
umount /mnt/iso
rm -rf /mnt/iso /root/VBoxGuestAdditions.iso

# Clean up to reduce size of Vagrant box
yum remove -y kernel-uek-devel-$(uname -r)
yum clean all
rm -rf /var/cache/* /usr/share/doc/*