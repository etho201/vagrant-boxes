source "virtualbox-iso" "ol7u2" {
  guest_os_type    = "Oracle_64"
  # iso_url          = "/Users/ebthomse/Documents/ISOs/OracleLinux-R7-U2-Server-x86_64-dvd.iso"
  iso_url          = "http://mirrors.kernel.org/oracle/OL7/u2/x86_64/OracleLinux-R7-U2-Server-x86_64-dvd.iso"
  # iso_checksum     = "none"
  iso_checksum     = "sha1:03e048f23d798c8e8e7935fab76245c2f1341378"
  ssh_username     = "root"
  ssh_password     = "vagrant"
  headless         = "true"
  ssh_wait_timeout = "30m"
  http_directory   = "http"
  boot_command = [
    "<up><tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ol7-ks.cfg setup_swap=yes <enter>"
  ]
  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--graphicscontroller", "vmsvga"],
    ["modifyvm", "{{.Name}}", "--memory", "1024"],
    ["modifyvm", "{{.Name}}", "--cpus", "2"],
  ]
  shutdown_command = "shutdown -P now"
}

build {
  sources = ["sources.virtualbox-iso.ol7u2"]

  provisioner "shell" {
    script = "scripts/vagrant-base-box.sh"
  }

  post-processor "vagrant" {
    output = "ol7-ksplice-dirtycow.box"
  }
}