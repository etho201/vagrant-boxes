# Oracle Linux Automation Manager (OLAM)

1. In your terminal, clone this repository, then navigate to the `oracle-linux-automation-manager`.

    ```bash
    git clone git@github.com:etho201/vagrant-boxes.git
    cd vagrant-boxes/oracle-linux-automation-manager/
    ```

2. Before we run `vagrant up`, we need to create a `variables.yaml` file with your preferences on certain settings. Run the below command with your values to create the variables file and place in the same directory as the Vagrantfile.

    ```bash
    cat <<EOF > variables.yaml
    ---
    hostname: 192.168.56.20
    email: root@localhost
    password: Password1
    sample_deployment: true
    EOF
    ```

3. (**OPTIONAL**) To configure the OLAM project automatically, create another variables file (called `variables.yml`) inside the scripts directory. Run the below command with your values to create that variables file.

    ```bash
    cat <<'EOF' > scripts/variables.yml
    ---
    - github_username: your_github_username
    - github_pat: ghp_AaBbCcDd112233445566778899
    - scm_url: https://github.com/etho201/olam-sample-project
    - scm_branch: main
    - project_name: OLAM Sample Project
    - project_description: Automated deployments with OLAM
    - playbook: playbook.yml
    - vault_password: Password1
    - inventory:
      - name: Atlanta
        host_filter: 192.168.56.[21-22]
      - name: Raleigh
        host_filter: 192.168.56.[23-24]
    EOF
    ```
    > **NOTE:** Creating this variables.yml file is optional and only required if you set `sample_deployment` to false. If that value is set to true, this `variables.yml` file will be generated automatically.

    > **NOTE:** In this [sample project](https://github.com/etho201/olam-sample-project), the Ansible Vault password is `Password1`, and that is used to decrypt the `admin_secret` password contained in `secrets.yml`.

    > **NOTE:** You can use the above variables as is, and in the future you can fork that repository to create your own project with your own bespoke configurations.

    > **NOTE:** A valid `github_username` and `github_password` is only required if your project is contained in a private repository.

4. Now that you've got your variables files, go ahead and fire things up:

    ```bash
    vagrant up
    ```

5. When vagrant is complete, navigate to http://192.168.56.20 to access the OLAM GUI.

    > Username: `admin`
    > Password: `Password1`