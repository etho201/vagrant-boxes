# Oracle Linux Manager

This Vagrant box installs and configures the latest Oracle Linux Manager (formerly Spacewalk) on the latest Oracle Linux 7 release. It will automatically configure a username and password for Oracle Linux Manager, automatically sets up channels and repositories for Oracle Linux 7, Oracle Linux 8, as well as Ksplice. It will then spin up a OL7 host and OL8 host and automatically register them to the Oracle Linux Manager.

## Getting started:

1. Clone in this repository, and run:

    ```bash
    vagrant up
    ```

2. Once everything is complete, you can access Oracle Linux Manager in your browser at: https://192.168.56.10

    - Username: `admin`
    - Password: `Password1`


    > **Note:** If you wish to change these credentials, do so before running `vagrant up` by modifing the `first-user.sh` file.

3. To SSH into the machines:

    ```bash
    vagrant ssh server  # This is the Oracle Linux Manager server
    vagrant ssh client7 # this is the OL7 client that is registered to OLM
    vagrant ssh client8 # this is the OL8 client that is registered to OLM
    ```

---

## Access to ULN

If you wish to automate syncing with ULN, modify the `secret.sh.sample` in the `scripts/` directory by inputting the Oracle SSO username and password you use for ULN access. Once done, rename this file to `secret.sh`. When running `vagrant up`, if the `secret.sh` file exists and properly configured, it will automatically sync the Ksplice channels once OLM is up and running.

---

## Git Submodule

You may have noticed there is a Git submodule configured with this repository, that is because this submodule contains code that has not been made available to the public. If you have access to the private repository the submodule references, you may pull this in with:

<details open>
<summary>Option 1 (you already have the <code>vagrant-boxes</code> repo cloned)</summary>


```bash
git submodule update --init
```
   
Check for updates with:
```
git submodule update
```
</details>

<details>
<summary>Option 2 (you are cloning the <code>vagrant-boxes</code> repo for the first time)</summary>

```bash
git clone --recurse-submodules git@github.com:etho201/vagrant-boxes.git
```
</details>
