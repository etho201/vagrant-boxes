# Install WireGuard
dnf install -y wireguard-tools iproute qrencode
umask 077
wg genkey | tee /etc/wireguard/privatekey | wg pubkey > /etc/wireguard/publickey

# Enable sending network packages from one network interface to another one on the same device
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.forwarding = 1" >> /etc/sysctl.conf
sysctl -p

# Configure wg0.conf for the server
echo "[Interface]
Address = 192.168.33.1/24
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE; ip6tables -A FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE; ip6tables -D FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
ListenPort = ${LISTEN_PORT}
PrivateKey = $(cat /etc/wireguard/privatekey)" > /etc/wireguard/wg0.conf

# Create clients
mkdir -p /etc/wireguard/clients

## user1
wg genkey | tee /etc/wireguard/clients/user1.key | wg pubkey > /etc/wireguard/clients/user1.key.pub
echo "[Interface]
PrivateKey = $(cat /etc/wireguard/clients/user1.key)
Address = 192.168.33.101/24
DNS = 1.1.1.1, 1.0.0.1

[Peer]
PublicKey = $(cat /etc/wireguard/publickey)
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = $([[ ${DOMAIN} = false ]] && curl ifconfig.me || echo ${FQDN}):${LISTEN_PORT}" > /etc/wireguard/clients/user1.conf

## Add clients to server config (wg0.conf)
echo "[Peer]
PublicKey = $(cat /etc/wireguard/clients/user1.key.pub)
AllowedIPs = 192.168.33.101/24" >> /etc/wireguard/wg0.conf

# Start wg0
wg-quick up wg0

# Generate QR code for easy connection
qrencode -t ansiutf8 < /etc/wireguard/clients/user1.conf