# Oracle Linux 8 GNOME Vagrant Box

This Vagrant Box is not hosted in the public Vagrant registry, so you'll first need to build it yourself using Packer. Packer will create an Oracle Linux 8.5 virtual machine using the "Server with GUI" option and will be configured to boot into the GNOME desktop environment when launched.

## Getting Starting:

```
packer build ol8-gnome.pkr.hcl
vagrant up
```

The IP address for the VM will be: `192.168.56.15`