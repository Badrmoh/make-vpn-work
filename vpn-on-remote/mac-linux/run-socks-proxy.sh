#!/bin/bash

SCRIPT_PATH=$(realpath $(dirname $0))
cd $SCRIPT_PATH

tunnel_up(){
  if [[ ! -S relay-host-dynamic.socket ]];then
    ssh -q -ND 8080 relay-host
  fi
}

tunnel_up
