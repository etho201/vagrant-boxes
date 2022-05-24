# WireGuard VPN Server

1. Before we run `vagrant up`, we need to create a `variables.yaml` file that contains our VPN preferences. Run the below command (with your credentials) to create the variables file and place in the same directory as the Vagrantfile.

    ```bash
    cat <<EOF > variables.yaml
    ---
    domain:
      enabled: false
      fqdn: YOUR_DOMAIN.duckdns.org
    listen_port: 51820
    EOF
    ```