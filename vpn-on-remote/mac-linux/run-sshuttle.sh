#!/bin/bash

SCRIPT_PATH=$(realpath $(dirname $0))
REALY_HOST_IP=$(ssh -G relay-host | awk '$1 == "hostname" { print $2 }')
cd $SCRIPT_PATH

if [[ $(uname -s) == "Darwin" ]];then
  export PATH=$PATH:/opt/homebrew/opt/openvpn/sbin/:/opt/homebrew/bin/
fi

tunnel_up(){
  sshuttle -r relay-host -x $REALY_HOST_IP --dns 0/0
}

tunnel_up
