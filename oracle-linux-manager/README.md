# Oracle Linux Manager

This Vagrant box installs and configures the latest Oracle Linux Manager (formerly Spacewalk) on the latest Oracle Linux 7 release. It will automatically configure a username and password for Oracle Linux Manager, automatically sets up channels and repositories for Oracle Linux 7, Oracle Linux 8, as well as Ksplice. It will then spin up a OL7 host and OL8 host and automatically register them to the Oracle Linux Manager.

## Getting started:

1. Before we run `vagrant up`, we need to create a `variables.yaml` file to specify the IP address for the Oracle Linux Management server. Whatever IP that you specify, the resulting client IPs will be incremented by one respectively. Run the below command (with your desired IP address) to create the variables file and place in the same directory as the Vagrantfile.

    ```bash
    cat <<EOF > variables.yaml
    ---
    hostname: 192.168.56.10
    ```

2. Now that you have your variables file, go ahead and fire things up:

    ```bash
    vagrant up
    ```

3. Once everything is complete, you can access Oracle Linux Manager in your browser at: https://192.168.56.10 (or whatever IP address you specified as your hostname)

    - Username: `admin`
    - Password: `Password1`


    > **Note:** If you wish to change these credentials, do so before running `vagrant up` by modifing the `first-user.sh` file.

4. To SSH into the machines:

    ```bash
    vagrant ssh olm  # This is the Oracle Linux Manager server
    vagrant ssh client7 # this is the OL7 client that is registered to OLM
    vagrant ssh client8 # this is the OL8 client that is registered to OLM
    ```

---

## Access to ULN

If you wish to automate syncing with ULN, modify the `secret.sh.sample` in the `scripts/` directory by inputting the Oracle SSO username and password you use for ULN access. Once done, rename this file to `secret.sh`. When running `vagrant up`, if the `secret.sh` file exists and properly configured, it will automatically sync the Ksplice channels once OLM is up and running.

---

## Git Submodule

You may have noticed that a Git submodule is configured with this repository; that is because this submodule contains code that has not been made available to the public. If you have access to the [private repository](https://github.com/etho201/olm-api/) that the submodule references, you may pull this in with:

<details open>
<summary>Option 1 (you already have the <code>vagrant-boxes</code> repo cloned)</summary>

```bash
git submodule update --init
```

> **NOTE:** Once you have the submodule cloned, you can check for updates with:
> ```bash
> git submodule update --remote
> ```

</details>

<details>
<summary>Option 2 (you are cloning the <code>vagrant-boxes</code> repo for the first time)</summary>

```bash
git clone --recurse-submodules git@github.com:etho201/vagrant-boxes.git
```

> **NOTE:** Once you have the submodule cloned, you can check for updates with:
> ```bash
> git submodule update --remote
> ```

</details>