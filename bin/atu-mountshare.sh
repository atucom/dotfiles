#!/bin/bash
#$0 DOMAIN/user%password //10.1.1.1/SYSVOL
#if the mounting fails, make sure you have cifs-utils install from apt-get. Kali2 doesnt seem to have it installed by default
if [[ -z $1 ]] || [[ -z $2 ]] ; then
	echo "Mounts a share with given creds"
	echo " $0 'DOMAIN/user%password' //HOST/SHARE"
else
  if [[ $(which mount.cifs > /dev/null; echo $?) == "1" ]] ; then
    echo "You dont have mount.cifs installed, install the cifs-utils package"
    exit 1
  fi
	credentials="$1" #smbclient/winexe format creds as first arg
	username="$(printf '%s' "$credentials" | cut -d '/' -f2 | cut -d '%' -f1)" #grab the username out of the first arg
  domain="$(printf '%s' "$credentials" | cut -d '/' -f1)"
  pass="$(printf '%s' "$credentials" | cut -d '/' -f2 | cut -d '%' -f2-)"
	share="$2" #second arg is the share to mount
	mountpoint="/mnt/mountshare/${username}/${share}" #default mountpoint
	mkdir -p "$mountpoint" #create the mountpoint dir
	mount.cifs "$share" "$mountpoint" -o user="$username",dom="$domain",pass="$pass" #mount the share
	if [[ $? == "0" ]]; then
			echo "Mounted to $mountpoint"
      cd $mountpoint
		else
			echo "Mounting failed, exiting"
			exit 1
	fi
fi
