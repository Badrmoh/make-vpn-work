#!/bin/bash

SCRIPT_PATH=$(realpath $(dirname $0))
VPN_SERVER_IP=${VPN_SERVER_IP:?Provide VPN Server IP address!}
cd $SCRIPT_PATH

if [[ $(uname -s) == "Darwin" ]];then
  export PATH=$PATH:/opt/homebrew/opt/openvpn/sbin/:/opt/homebrew/bin/
fi

tunnel_up(){
  if [[ ! -f relay-host-sshuttle.pid ]];then
    sshuttle -D --pidfile relay-host-sshuttle.pid -r relay-host ${VPN_SERVER_IP:?Provide VPN Server IP address!}
  fi
}

tunnel_down(){
  if [[ -f relay-host-sshuttle.pid ]];then
    kill $(cat relay-host-sshuttle.pid)
  fi
}

trap tunnel_down INT KILL TERM 

tunnel_up

[[ $? -eq 0 ]] && \
  openvpn --config $SCRIPT_PATH/../../client.ovpn
