This setup requires configured and running vpn client on ssh server preferably in the same region as the VPN server.

# Dynamic Port Forwarding / Socks proxy
## Kitty / Putty
1. Download kitty / Putty
2. Generate / Convert to .ppk key format using puttygen
3. Create Putty Session and configure the following
    - Hostname: `<user>@<relay-hostname-or-ip>`
    - Sidemenu -> SSH -> Auth: Add .ppk file in `Private key file for authentication`
    - Sidemenu -> SSH -> Tunnels:
        - Select `Dynamic`
        - Add Source port: `127.0.0.1:8080`
    - Sidemenu -> Session: Give the session a name and click on `Save`
4. Click on `Open` or `Start`

## Configure Windows to use Socks Proxy
1. From search find `Proxy Settings`
2. At `Manual proxy setup`, click on `Set up`
3. Add the following address `http://socks=127.0.0.1`
4. Add the following port `8080`
5. Check on `Don't use the proxy for local (intranet) addresses`
6. Click on `Save`

At this point, vpn can be reached from browser and **terminal**.