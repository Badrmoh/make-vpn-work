This setup requires an ssh server preferably in the same region as the VPN server
# .ovpn file
The scripts in this repository expect that a file named `client.ovpn` to exist in the root of this repository. 
Copy your `.ovpn` to the root of this repository before using any of the scripts.
 
# Linux

Install openvpn : `sudo apt install openvpn`
Install sshuttle (if used) : `sudo aot install sshuttle`

# MacOS

We need to use openvpn cli instead of any OpenVPN Client, in order to make it easier to use scripts.

1. `brew install openvpn`
2. `sudo mkdir /etc/openvpn/`
3. `sudo cp update-resolv-conf-mac /etc/openvpn/update-resolv-conf`
4. `sudo chmod +x /etc/openvpn/update-resolv-conf`

In order to update DNS records, add the following lines in _your_ `client.ovpn`:

```
script-security 2
up /etc/openvpn/update-resolv-conf
down /etc/openvpn/update-resolv-conf
```

## sshuttle

Install sshuttle (if used) : `brew install sshuttle`

## Apple Shortcut

Select the script to run after starting the shortcut.
Download Apple Shortcut: [vpn-over-ssh](https://www.icloud.com/shortcuts/3a1d84d011614a1cb9fdaf33dc6404f1)

# Smartphones support

## TODO

In order to use this method with smartphones, there are two options:

1. Download an App that allow using local/dynamic port forwarding (on iOS blink shell)
2. Setup the ssh connection
3. Add the proper configuration to `client.ovpn` file

   a. Local Port Forwarding: replace `remote` line with `remote 127.0.0.1 8080 tcp`

   b. Dynamic Port Forwarding: add `socks-proxy 127.0.0.1 8080`

4. Import _your_ `client.ovp` file

5. Start VPN

Another option is to expose socks proxy or local port from a computer, and adjust `client.ovpn` file accordingly.
