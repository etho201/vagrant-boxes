# ULN Search

- [ULN Search](#uln-search)
  - [Vagrant Box](#vagrant-box)
  - [Container Solution:](#container-solution)
  - [Additional Notes:](#additional-notes)
  - [Cleanup](#cleanup)

## Vagrant Box

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

## Container Solution:

Want to do the same thing with a container instead? Using a Vagrant box is a bit overkill for what we're trying to do here. Containers are faster and more efficient than virtual machines, and are perfect when you only need to perform single-purpose operations. Using a container to export a list of packages to a text file is a good use-case for containers.

1. Before we run the container, we need to create a `variables.yaml` file that contains our ULN credentials. Refer to step one from [above](#uln-search).

1. Now, simply run the following command to launch an OL8 container that will create a file called `uln-packages.txt` containing the entire ULN catalog:

    ```bash
    podman run --rm --hostname=uln-search -v ${PWD}:/data \
    --env USERNAME=$(podman run --rm -v ${PWD}:/workdir mikefarah/yq '.uln.username' variables.yaml) \
    --env PASSWORD=$(podman run --rm -v ${PWD}:/workdir mikefarah/yq '.uln.password' variables.yaml) \
    --env CSI=$(podman run --rm -v ${PWD}:/workdir mikefarah/yq '.uln.csi' variables.yaml) \
    -t --entrypoint /data/scripts/provision.sh oraclelinux:8
    ```

    > **NOTE:** There are many ways to do this, but in this case we're using sub-processes to parse the credentials from the `variables.yaml` file. 

## Additional Notes:

- You can omit channels by editing `scripts/provision.sh`. For example, if you want to omit channels related to earlier versions  of Oracle Linux, add something like this into the `if` statement that builds the list of channels:

    ```
    && [[ $i != "el3_"* ]] && [[ $i != "el4_"* ]] && [[ $i != "el5_"* ]] && [[ $i != "ol5_"* ]] && [[ $i != "ol6_"* ]] && [[ $i != "ol7_"* ]]
    ```

- Release RPMs for the Oracle Linux Yum Server: https://yum.oracle.com/getting-started.html

    ```
    podman run --rm --hostname=yum-search -v ${PWD}:/data \
    -t --entrypoint /data/scripts/yum.sh oraclelinux:8
    ```

---

## Cleanup

- Each time you run this project, it will register a new system in the ULN. The list of registered systems can grow quite large over time.
- If you wish to remove these automatically, install the Selenium IDE extension in either Firefox or Chrome and run the `\scripts\cleanup.side` file using the Selenium IDE. Modify the target under the `timms` command to change the amount of systems (default is 25) to delete from the list.