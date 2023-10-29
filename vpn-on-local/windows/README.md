This setup requires an ssh server preferably in the same region as the VPN server

# Local Port Forwarding
## Kitty / Putty
1. Download kitty / Putty
2. Generate / Convert to .ppk key format using puttygen
3. Create Putty Session and configure the following
    - Hostname: `<user>@<relay-hostname-or-ip>`
    - Sidemenu -> SSH -> Auth: Add .ppk file in `Private key file for authentication`
    - Sidemenu -> SSH -> Tunnels:
        - Select `Local`
        - Add Source port: `127.0.0.1:8080`
        - Add Destination port: `<vpn-server-ip>:port` You will find this in vpn configuration file
    - Sidemenu -> Session: Give the session a name and click on `Save`
4. Click on `Open` or `Start`

## OpenVpn
1. Add the following line to your `client.ovpn`
    - `remote 127.0.0.1 8080`

# Dynamic Port Forwarding
OpenVPN Connect on windows doesnt support `socks-proxy` option, hence this method is not available