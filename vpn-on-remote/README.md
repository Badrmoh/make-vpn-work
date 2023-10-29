a relay-host which has already established connection to the VPN server can be used to *relay* traffic over ssh without needing to setup anything on local host.

# Relay Host
It refers to the linux ssh server that has a public IP address. It is assumed that ssh access is available to relay-host and proper configuration exists in `/etc/ssh/ssh_config.d/relay-host`.

Additional setup is needed:
1. Install openvpn : `sudo apt install openvpn`
2. Copy your `client.ovpn` to relay-host : `scp relay-host:~/`
3. Access relay-host using ssh : `ssh relay-host`
4. Move `client.ovpn` to `/etc/openvpn/client/client.ovpn`
5. Start openvpn client : `sudo systemctl start openvpn-client@client`

---

# Smartphones support
## TODO

This method has not yet been investigated for smartphones.
