#!/bin/bash

SCRIPT_PATH=$(realpath $(dirname $0))
cd $SCRIPT_PATH

if [[ $(uname -s) == "Darwin" ]];then
  export PATH=$PATH:/opt/homebrew/opt/openvpn/sbin/:/opt/homebrew/bin/
fi

tunnel_up(){
  if [[ ! -S relay-local-host.socket ]];then
    ssh -qf -NL 8080:3.66.235.60:1194 relay-host -o ControlMaster=yes -o ControlPersist=10h -o ControlPath=relay-local-host.socket
  fi
}

tunnel_down(){
  ssh -S relay-local-host.socket -O exit relay-host
}

trap tunnel_down INT KILL TERM 

tunnel_up

[[ $? -eq 0 ]] && true
  openvpn --config $SCRIPT_PATH/../../client.ovpn --remote 127.0.0.1 8080 
