a relay-host which has already established connection to the VPN server can be used to *relay* traffic over ssh without needing to setup anything on local host.

# Relay Host
It refers to *preferrably* a linux ssh server that has a public IP address.

## Linux and MacOS
Add in `/etc/ssh/ssh_config.d/relay-host`:
```
Host relay-host
    HostName <relay-host-ip-or-hostname>
    User <user>
    IdentityFile <path-to-private-key>
```

## On Relay Host (OpenVPN)
Additional setup is needed:
1. Install openvpn : `sudo apt install openvpn`
2. Copy your `client.ovpn` to relay-host : `scp relay-host:~/`
3. Access relay-host using ssh : `ssh relay-host`
4. Move `client.ovpn` to `/etc/openvpn/client/client.ovpn`
5. Check which service is managing dns:
    - Run `sudo systemctl status systemd-resolved`
    - In case this service appears to be running, it is needed then to update `client.ovpn` configurations. See [Using systemd-resolved](#using-systemd-resolved)
    - If `systemd-resolved` was not found, then proceed step `6`, otherwise 
6. Start openvpn client : `sudo systemctl start openvpn-client@client`
7. Check that DNS is properly configured by running `resolvectl status -i tun0`
8. Allow `relay-host` to forward traffic by executing the following commands
    ```
    echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
    echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p /etc/sysctl.conf
    ```

### Using systemd-resolved
1. Install [this script](https://github.com/jonathanio/update-systemd-resolved/blob/master/update-systemd-resolved) under `/etc/openvpn/client/`
2. Replace (or add) `up` and `down` lines on `client.ovpn` with the following:
```
up /etc/openvpn/update-systemd-resolved
down /etc/openvpn/update-systemd-resolved
```

### Tailscale on Relay Host
tailscale can forward traffic to `relay-host` where VPN and DNS can be routed and resolved. In case this method is going to be used, tailscale must be installed and configured on all both nodes; `localhost` and `relay-host`.

1. Register and install tailscale on `relay-host`: [link](https://tailscale.com/download/)
2. Run `tailscale login` and use the link to authenticate
3. Run Tailscale: `sudo tailscale up --hostname=relay-host --advertise-routes=<vpn-subnet1>,<vpn-subnet2>,..`
    - Subnets in the command above are found in routes, after connecting to VPN on `relay-host`, by simply running `route -n | grep tun0 | grep -v "0.0.0.0"`.
4. Get DNS ip address. Skip till step `7` if VPN services are resolvable on public DNS servers.
    - To get DNS server address run `resolvectl status -i tun0` and look for addresses blonging to `tun0` interface.
    - In case `systemd-resolved` is not used look in `/etc/resolv.conf` and get the DNS ip address.
    - There will also be subdomain information which will be needed as well.
5. On tailscale's [admin console](https://login.tailscale.com/admin/dns), add custom name server with `split DNS`. Add subdomain and DNS ip address to resolve it.
6. Tailscale is ready on `relay-host`

### Tailscale on Local Host
Once tailscale is setup on `relay-host`, tailscale can be as well installed on localhost. All operating systems support tailscale.
#### **MacOS** and **Windows**
1. Install from website
2. Authorize tailscale and login
3. Check on the following settings:
- Use Tailscale DNS Settings
- Use Tailscale Subnets

#### **Linux**
1. Install tailscale locally : follow [Tailscale on Relay Host](#tailscale-on-relay-host)
2. Run tailscale : `sudo tailscale up --accept-dns --accept-routes`

---

# Smartphones support
## Tailscale
Tailscale is supported on iOS and Android.
