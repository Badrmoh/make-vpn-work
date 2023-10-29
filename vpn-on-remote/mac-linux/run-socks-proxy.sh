#!/bin/bash

SCRIPT_PATH=$(realpath $(dirname $0))
cd $SCRIPT_PATH

tunnel_up(){
  if [[ ! -S relay-host-dynamic.socket ]];then
    ssh -qf -ND 8080 relay-host -o ControlMaster=yes -o ControlPersist=10h -o ControlPath=relay-host-dynamic.socket
  fi
}

tunnel_down(){
  ssh -S relay-host-dynamic.socket -O exit relay-host
}

trap tunnel_down INT KILL TERM 

tunnel_up
