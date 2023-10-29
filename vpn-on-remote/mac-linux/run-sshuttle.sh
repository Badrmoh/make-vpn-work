#!/bin/bash

SCRIPT_PATH=$(realpath $(dirname $0))
cd $SCRIPT_PATH

if [[ $(uname -s) == "Darwin" ]];then
  export PATH=$PATH:/opt/homebrew/opt/openvpn/sbin/:/opt/homebrew/bin/
fi

tunnel_up(){
  if [[ ! -f relay-host-sshuttle.pid ]];then
    sshuttle -D --pidfile relay-host-sshuttle.pid -r relay-host --dns 0/0
  fi
}

tunnel_down(){
  if [[ -f relay-host-sshuttle.pid ]];then
    kill $(cat relay-host-sshuttle.pid)
  fi
}

trap tunnel_down INT KILL TERM 

tunnel_up
