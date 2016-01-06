#!/bin/bash
#$0 DOMAIN/user%password //10.1.1.1/SYSVOL
if [[ -z $1 ]] || [[ -z $2 ]] ; then
	echo "Searches through a share for cpassword occurences"
	echo " $0 'DOMAIN/user%password' //HOST/SYSVOL"
else
  if [[ $(which mount.cifs > /dev/null; echo $?) == "1" ]] ; then
     echo "You dont have mount.cifs installed, install the cifs-utils package"
     exit 1
  fi
	credentials="$1" #smbclient/winexe format creds as first arg
	username="$(printf '%s' "$credentials" | cut -d '/' -f2 | cut -d '%' -f1)" #grab the username out of the first arg
	share="$2" #second arg is the share to mount
	mountpoint="/mnt/mountshare/${username}/${share}" #default mountpoint
	mkdir -p "$mountpoint" #create the mountpoint dir
	mount.cifs "$share" "$mountpoint" -o user="$credentials" #mount the share
	currentwd="$(pwd)"
	if [[ $? == "0" ]]; then
			echo "[+]Mounted to $mountpoint, searching for cpassword"
			sleep .5
			cd "$mountpoint"
			grep --color=always -r -i cpassword *
			echo "[+]Done searching, now unmounting"
			cd "$currentwd"
			umount "$mountpoint"
		else
			echo "[-]Mounting failed, exiting"
			exit
	fi
fi
