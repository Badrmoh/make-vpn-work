#!/bin/bash

SCRIPT_PATH=$(realpath $(dirname $0))
cd $SCRIPT_PATH

if [[ $(uname -s) == "Darwin" ]];then
  export PATH=$PATH:/opt/homebrew/opt/openvpn/sbin/:/opt/homebrew/bin/
fi

tunnel_up(){
  if [[ ! -S relay-dynamic-host.socket ]];then
    ssh -qf -ND 8080 relay-host -o ControlMaster=yes -o ControlPersist=10h -o ControlPath=relay-dynamic-host.socket
  fi
}

tunnel_down(){
  ssh -S relay-dynamic-host.socket -O exit relay-host
}

trap tunnel_down INT KILL TERM 

tunnel_up

[[ $? -eq 0 ]] && true
  openvpn --config $SCRIPT_PATH/../../client.ovpn --socks-proxy 127.0.1 8080
