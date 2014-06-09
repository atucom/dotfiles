#!/bin/bash
#atu-nfs-count.sh
#find all world readable files in an nfs share
#expects targets in "1.2.3.4:/share/dir" format
#mounts remote nfs share in current directory under dir
#if files were found, it will leave the mount alone so you can look through it
#if none were found, it unmounts and deletes the mountdir

if [[ -z $1  ]]; then
  echo "Automounts open nfs shares and checks for number of readable files"
  echo usage: $0 1.2.3.4:/share/dir
  exit
fi
fullshare="$1"
path=${fullshare////?} # we do this to keep the special '/' safe
##################################
mkdir -p "$path"
mount.nfs "$fullshare" "$path" -r -o nolock
find "$path" -type f -readable -exec ls -lh {} \;  2> /dev/null > "$path.filelist" #create a file with a listing of the readable file paths
number_of_files=$(cat "$path.filelist" | wc -l) #and no, this isnt UUOC
if [[ "$number_of_files" == "0" ]]; then
  echo "$fullshare - No world readable files found"
  umount "$path"
  rm -rf "$path"
else
  echo "$fullshare - $number_of_files world readable files found"
fi