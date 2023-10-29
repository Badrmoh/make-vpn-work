# Make VPN work

Some countries block VPN for whatever reason, and this is a collection of methods to run VPN and overcome this blockage.

# Prerequisties

## Cloud Instance with SSH access

You can test if one of the methods work using one of the free tier cloud instances avaialble. (*preferrably Linux*)

On your local linux or mac, add in `/etc/ssh/ssh_config.d/relay-host`:
```
Host relay-host
    HostName <relay-host-ip-or-hostname>
    User <user>
    IdentityFile <path-to-private-key>
```

## Windows

Kitty / Putty is the preferred client to be used. However the methods can be done using ssh from windows terminal.


# Categories

### Run vpn client on localhost

Generally, this method doesnt require much setup.

### Run vpn client on remote / relay host

This method requires extra steps, but it usually performs better, since VPN packets are not encapsulated in other packets, rather there is no direct connection to VPN server

# VPN Protocols

Currently, only openvpn has been tested using these methods to work _mostly_.
