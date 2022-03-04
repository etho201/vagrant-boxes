# ULN Search

1. Before we run `vagrant up`, we need to create a `variables.yaml` file that contains our ULN credentials. Run the below command (with your credentials) to create the variables file and place in the same directory as the Vagrantfile.

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

1. To connect to the system, you can simply run:

    ```bash
    vagrant ssh
    ```

1. Once connected, you can use `dnf` to search for package names. For example, if you want to seach for packages that contain the word "ansible", you can run:

    ```bash
    dnf -C list *ansible*
    ```
    > **NOTE:** `-C` caches the list so you don't have to download the data each time.

---

## Additional Resources:
- Tips on useful search techniques can be found here: https://unix.stackexchange.com/questions/6521/how-to-force-yum-search-to-use-local-metadata-cache