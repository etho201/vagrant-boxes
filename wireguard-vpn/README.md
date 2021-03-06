# WireGuard VPN Server

1. Before we run `vagrant up`, we need to create a `variables.yaml` file that contains our VPN preferences. Run the below command (with your credentials) to create the variables file and place in the same directory as the Vagrantfile.

    ```bash
    cat <<EOF > variables.yaml
    ---
    duckdns:
      enabled: false
      token: DUCK_DNS_TOKEN
      subdomain: YOUR_DOMAIN
      fqdn: YOUR_DOMAIN.duckdns.org
    listen_port: 51820
    network: nat
    EOF
    ```

2. Once configured, run:

    ```bash
    vagrant up
    ```

3. Once everything is complete, you will be given a QR code with the settings. To display this again, run:

    ```bash
    vagrant ssh -- -t 'qrencode -t ansiutf8 < /etc/wireguard/clients/user1.conf'
    ```

---

## Performance

Vagrant will create the VM using NAT networking, which isn't the most performant. To improve throughput, after the VM is created, shut it down and change the network to `Bridged Adapter` and the type to `Paravirtualized Network (virtio-net)`.

> **NOTE:** Changing the network card manually will result in needing to start the VM from VirtualBox (instead of Vagrant). To maintain the ability to access/modify the VM, it would be a good idea to create a new user beforehand and allow SSH (by editing `/etc/ssh/sshd_config` and setting `PasswordAuthentication` to `yes`).

---

## Connect:

:star:

```bash
sudo podman run --rm -v ${PWD}/wg0.conf:/config/wg0.conf --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun -td --hostname wireguard --name=wireguard --network host linuxserver/wireguard

sudo podman exec -it wireguard wg-quick down wg0
sudo podman kill wireguard
```

```bash
sudo podman run -d \
  --name=wireguard \
  --cap-add=NET_ADMIN \
  --device /dev/net/tun:/dev/net/tun \
  --network host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/New_York \
  -v ${PWD}/wg0.conf:/config/wg0.conf \
  -v /lib/modules:/lib/modules \
  --restart unless-stopped \
  linuxserver/wireguard

sudo podman kill wireguard
sudo podman rm wireguard
wg-quick down ./wg0.conf
```

---

# CIDR Notation:

- 10.0.0.0/24 = 10.0.0.0 to 10.0.0.255 = 256 hosts
- 10.0.0.0/32 = 10.0.0.0 = 1 host



## Resources:
- https://wiki.archlinux.org/title/WireGuard#Specific_use-case:_VPN_server
- https://www.ipaddressguide.com/cidr
- https://www.digitalocean.com/community/tutorials/understanding-ip-addresses-subnets-and-cidr-notation-for-networking



---

# Troubleshooting:

## Performance:

1. https://docs.oracle.com/en/virtualization/virtualbox/6.0/user/network_performance.html

## Windows:
1. List port forwarding settings within VirtualBox:
    ```bash
    VBoxManage showvminfo "WireGuard VPN" --machinereadable | Select-String "Forwarding*"
    ```

2. Ensure port is open via Windows Firewall
    ```bash
    netsh advfirewall firewall show rule name="WireGuard VPN" dir=in type=dynamic
    ```

3. 


