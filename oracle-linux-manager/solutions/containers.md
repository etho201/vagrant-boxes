# Containers

## Allow containers to access OLM repositories without registering

1. Expose the directory that contains the repos to the Apache web server:

    ```bash
    cd /var/www/html/pub
    ln -s /var/satellite/redhat/1/ ./
    ```

    > **NOTE:** This will be available here: http://192.168.56.10/pub/1/

2. Run `createrepo` so Yum/DNF can recognize it has a repository

    ```bash
    cd /var/www/html/pub/1
    createrepo .
    ```

---

1. On the OLM server:

    ```bash
    cd /var/satellite/redhat/1/
    createrepo .
    cd /var/www/html/pub
    ln -s /var/satellite/redhat/1/ ./
    ```

2. Then for a client (that isn’t registered to the OLM server), add a repo file:
    ```bash
    cat <<'EOF' > /etc/yum.repos.d/olm-demo.repo
    [olm_demo]
    name=OLM Demo
    baseurl=http://192.168.56.10/pub/1/
    gpgcheck=0
    enabled=1
    EOF
    ```

    > **NOTE:** This points to the location of the packages on the OLM server