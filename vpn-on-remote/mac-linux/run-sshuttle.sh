#!/bin/bash

SCRIPT_PATH=$(realpath $(dirname $0))
cd $SCRIPT_PATH

if [[ $(uname -s) == "Darwin" ]];then
  export PATH=$PATH:/opt/homebrew/opt/openvpn/sbin/:/opt/homebrew/bin/
fi

tunnel_up(){
  sshuttle -r relay-host --dns 0/0
}

tunnel_up
