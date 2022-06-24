# Oracle Linux Automation Manager (OLAM)

1. Before we run `vagrant up`, we need to create a `variables.yaml` file with your preferences on certain settings. Run the below command with your values to create the variables file and place in the same directory as the Vagrantfile.

    ```bash
    cat <<EOF > variables.yaml
    ---
    hostname: 192.168.56.20
    email: root@localhost
    password: Password1
    EOF
    ```

2. Now that you've got your variables file, go ahead and fire things up:

    ```bash
    vagrant up
    ```