# Oracle Linux 8 "Server with GUI" Vagrant Box

This Vagrant Box is not hosted in the public Vagrant registry, so you'll first need to build it yourself using Packer.

```
packer build ol8-gnome.pkr.hcl
vagrant up
```

The IP address for the VM will be: `192.168.56.15`