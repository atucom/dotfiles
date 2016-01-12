#!/bin/bash
#$0 domain name
if [[ -z $1 ]] ; then
  echo "Simply lists out the domain controllers for given AD domain name"
  echo " $0 target.local"
  exit 1
fi

dclist=$(dig -t SRV _ldap._tcp.dc._msdcs.$1 +short | awk '{print $4}')
pdc=$(dig -t SRV _ldap._tcp.pdc._msdcs.$1 +short | awk '{print $4}')

echo "[Primary Domain Controller:]"

host $pdc
echo

echo "[Other Domain Controllers:]"
for i in $( echo $dclist); do 
  host $i;done