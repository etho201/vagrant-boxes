# Oracle Linux 8 GNOME Vagrant Box

This Vagrant Box is not hosted in the public Vagrant registry, so you'll first need to build it yourself using Packer. Packer will create an Oracle Linux 8.5 virtual machine using the "Server with GUI" option and will configure the guest to boot into the GNOME desktop environment when launched. It will additionally install and set up the VNC remote access server software on an Oracle Linux 8 system to enable you to remotely operate the graphical desktop environment. 

## Getting Starting:

```
packer build ol8-gnome.pkr.hcl
vagrant up
```

The IP address for the VM will be: `192.168.56.15`

## VNC Access

Connect to the server using VNC. Password is `vagrant`

```
vnc://192.168.56.15:5901
```

> **INFO:** If you connect and only see a black screen, try rebooting (this probably only needs to be done the first time you connect).

---

# FAQ

## Gnome Login Loop:

If you see the Gnome login screen and if after logging in it reverts back to the login screen (over and over again), a workaround is to change the X display. To do this, press ctrl+F2 (or ⌘+F2 on Mac), enter your credentials, then enter the command `start x`.

> **NOTE:** This is probably caused by the VNC service occupying the default X display.