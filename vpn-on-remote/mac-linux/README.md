This setup requires configured and running openvpn client on ssh server preferably in the same region as the VPN server.
---

# Linux
## Run ssh Tunnel
Either Socks or sshuttle tunnel can be used from the scripts. Simply run either one of them

### Socks Proxy
In case Socks Proxy is used, the next steps must be configured


## Tailscale
1. Install tailscale from website : https://tailscale.com/download/
2. 
---

# MacOS
## Apple Shortcut
Select the script to run after starting the shortcut.
Download Apple Shortcut: [vpn-over-ssh](https://www.icloud.com/shortcuts/3a1d84d011614a1cb9fdaf33dc6404f1)

### Socks Proxy
1. System Settings
2. Network (choose your network)
3. Details (of your network)
4. Proxies
5. Toggle on SOCKS proxy
6. Add server as `127.0.0.1`, and port as `8080`
7. OK
8. Test Connection
