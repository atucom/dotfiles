#!/bin/bash

if [[ -z $1 ]]; then
    echo 'Takes a single IP and outputs the netbios name, domain, OS, and server version of the target'
    echo "Usage: $0 IPADDR"
else
    IPADDR="$1"
    os_info=$(smbclient -N -L "$IPADDR" 2>&1 | grep Domain | head -1)
    netbios_name=$(nmblookup -A "$IPADDR" | grep -v GROUP | grep '<00>' | awk '{print $1}')
    echo "$IPADDR" : "$netbios_name" : "$os_info"
fi