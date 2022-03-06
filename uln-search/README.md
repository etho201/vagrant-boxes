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

1. Once connected, you can use `dnf` to search for package names.

    - For example, if you want to seach for packages that contain the word "ansible", you can run:

        ```bash
        dnf -C list *ansible*
        ```
        > **NOTE:** `-C` caches the list so you don't have to download the data each time.

    - Create a list of all packages:

        ```bash
        dnf -C list all > uln-packages.txt
        ```
        > **NOTE:** Now you can search this list via `grep`. For example, to search for the word "ansible", just run: `grep -i ansible uln-packages.txt`

---

## Want to do the same thing with a container instead?

Containers are faster than virtual machines, and you can achieve the same results using containers. Here's how:

```bash
docker build -t oracle/uln-search .

docker run --rm --hostname=uln-search -v ${PWD}/data \
--env USERNAME=$(docker run --rm -v ${PWD}:/workdir mikefarah/yq e '.uln.username' variables.yaml) \
--env PASSWORD=$(docker run --rm -v ${PWD}:/workdir mikefarah/yq e '.uln.password' variables.yaml) \
--env CSI=$(docker run --rm -v ${PWD}:/workdir mikefarah/yq e '.uln.csi' variables.yaml) \
-t oracle/uln-search
```

> **NOTE:** There are many ways to do this, but in this case we're using sub-processes to parse the credentials from the `variables.yaml` file. 

## Additional Resources:
- Tips on useful search techniques can be found here: https://unix.stackexchange.com/questions/6521/how-to-force-yum-search-to-use-local-metadata-cache