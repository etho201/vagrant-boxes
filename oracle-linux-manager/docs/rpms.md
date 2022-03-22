# Upload custom list of RPMs

```
sudo su
cd /var/www/pub/
mkdir custom/
cd custom/

# place rpms here
# example:
# curl https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/s/spacecmd-2.6.16-1.el7.noarch.rpm -o spacecmd.rpm

createrepo .

spacecmd -- softwarechannel_create -l custom_rpms -n "Custom RPMs" -p oraclelinux7-x86_64 -a x86_64
spacecmd -- repo_create -n "External - Custom RPMs" -u "http://192.168.56.10/pub/custom" -t yum
spacecmd -- softwarechannel_addrepo custom_rpms "External - Custom RPMs" 
spacewalk-repo-sync -c custom_rpms
```