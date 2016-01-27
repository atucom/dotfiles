#!/bin/bash
#get default networking details
if [[ "$(uname)" == "Darwin" ]] ; then
  echo "Not yet supported on OSX"
  exit 1
fi

hname="$(hostname)"
default_int="$(ip r g 8.8.8.8 | grep dev | awk '{print $5}')"
default_ip="$(ip r g 8.8.8.8 | grep dev | awk '{print $7}')"
default_gw="$(ip r g 8.8.8.8 | grep dev | awk '{print $3}')"
default_nw="$(ip a sh "$default_int" | grep 'inet ' | awk '{print $2}')"
default_ns="$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}' | tr '\n' ', ')"
printf 'Hostname: %s\n' "$hname"
printf 'Intface: %s\n' "$default_int"
printf 'IP Addr: %s\n' "$default_ip"
printf 'Gateway: %s\n' "$default_gw"
printf 'Network: %s\n' "$default_nw"
printf 'DNS: %s\n' "$default_ns"
