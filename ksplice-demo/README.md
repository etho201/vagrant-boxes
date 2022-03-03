# Ksplice Demo

## Overview:

This Vagrant box is intended to provide an quick demonstration of the advantages of Oracle Ksplice. For this demonstration, we will take a look at the [Dirty COW bug](https://dirtycow.ninja/) (`CVE-2016-5195`) that came out in October of 2016. With that being said, we needed to deploy an operating system that was released before that timeframe. Oracle Linux 7.2 was released in November of 2015 so if you start from the installation media, it would not be patched and protected from the Dirty COW exploit.

The Dirty COW bug is a privilege escalation vulnerability in the Linux Kernel, so typically you would patch the kernel, but you wouldn't be protected until after a reboot. However, thanks to Ksplice, we can live-patch the kernel and protect our system on the fly without a reboot.

---

## Getting Starting:

1. This Vagrant Box is not hosted in the public Vagrant registry, so you'll first need to build it yourself using Packer. Packer will create an Oracle Linux 7.2 virtual machine and prepares it for use with Vagrant.

    ```bash
    packer build ol7-ksplice-dirtycow.pkr.hcl
    ```

1. Before we run `vagrant up`, we need to create a `variables.yaml` file that contains our ULN credentials. Run the below command to create the variables file and place in the same directory as the Vagrantfile.

    ```bash
    cat <<EOF > variables.yaml
    ---
    uln:
      username: YOUR_ORACLE_SSO@EMAIL.COM
      password: $(echo -e 'YOUR_ORACLE_SSO_PASSWORD')
      csi: YOUR_ORACLE_CSI
    EOF
    ```

1. Now that you've provided your ULN credentials, go ahead and fire things up:

    ```bash
    vagrant up
    ```

    > **NOTE:** The IP address for the VM will be: `192.168.56.10`

1. To connect to the system, you can simply run:

    ```bash
    vagrant ssh
    ```

1. Once connected, we will run an Ansible playbook to check if the system is vulnerable to the Dirty COW bug.

    ```bash
    ansible-playbook-3 -c local -i localhost, check.yml
    ```

## Protect your system with Ksplice

1. After the Ansible playbook runs, you should see that the system is vulnerable. :scream:

    No reason to worry though, because we can use Ksplice to quickly and easily patch the system while it's running, and protect it from the Dirty COW bug.

    ```bash
    uptrack-install hb94cdr2 -y
    ```

    > **NOTE:** In this case, we are specifying the Ksplice ID `hb94cdr2` which correlates to "CVE-2016-5195: Privilege escalation in copy-on-write memory mappings."

1. Now that the system is patched, let's run the Ansible Playbook again and see what it says.

    ```bash
    ansible-playbook-3 -c local -i localhost, check.yml
    ```
    
    You should see that the system is no longer vulnerable, and the best part is, we didn't even need to reboot the system to protect our system.

## Rolling back patches:

1. If for whatever reason something went wrong and you're experiencing issues after applying the patch, you can easily rollback the patch via:

    ```bash
    uptrack-remove hb94cdr2 -y
    ```