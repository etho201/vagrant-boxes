# Create new users

## Create a user identified as `user2`

1. Define the variables before running. Be sure to specify a unique USER and VPN_IP variable.

    ```bash
    USER=user2
    VPN_IP=192.168.33.102
    FQDN=YOUR_DOMAIN.duckdns.org
    LISTEN_PORT=51820
    DUCKDNS=true

    wg-quick down /etc/wireguard/wg0.conf

    wg genkey | tee /etc/wireguard/clients/${USER}.key | wg pubkey > /etc/wireguard/clients/${USER}.key.pub
    echo "[Interface]
    PrivateKey = $(cat /etc/wireguard/clients/${USER}.key)
    Address = ${VPN_IP}/32
    DNS = 1.1.1.1, 1.0.0.1

    [Peer]
    PublicKey = $(cat /etc/wireguard/publickey)
    AllowedIPs = 0.0.0.0/0, ::/0
    Endpoint = $([[ ${DUCKDNS} = false ]] && curl ifconfig.me || echo ${FQDN}):${LISTEN_PORT}" > /etc/wireguard/clients/${USER}.conf

    ## Add clients to server config (wg0.conf)
    echo "[Peer]
    # ${USER}
    PublicKey = $(cat /etc/wireguard/clients/${USER}.key.pub)
    AllowedIPs = ${VPN_IP}/32" >> /etc/wireguard/wg0.conf

    wg-quick up /etc/wireguard/wg0.conf

    qrencode -t ansiutf8 < /etc/wireguard/clients/${USER}.conf
    ```

2. The conf file for the new user can be found at:

    ```bash
    /etc/wireguard/clients/${USER}.conf
    ```