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