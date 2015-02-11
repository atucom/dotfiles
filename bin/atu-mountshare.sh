#!/bin/bash
#$0 DOMAIN/user%password //10.1.1.1/SYSVOL
if [[ -z $1 ]] || [[ -z $2 ]] ; then
	echo "Mounts a share with given creds"
	echo " $0 'DOMAIN/user%password' //HOST/SHARE"
else
	credentials="$1" #smbclient/winexe format creds as first arg
	username="$(printf '%s' "$credentials" | cut -d '/' -f2 | cut -d '%' -f1)" #grab the username out of the first arg
	share="$2" #second arg is the share to mount
	mountpoint="/mnt/mountshare/${username}/${share}" #default mountpoint
	mkdir -p "$mountpoint" #create the mountpoint dir
	mount.cifs "$share" "$mountpoint" -o user="$credentials" #mount the share
	if [[ $? == "0" ]]; then
			echo "Mounted to $mountpoint"
		else
			echo "Mounting failed, exiting"
			exit 1
	fi
fi
