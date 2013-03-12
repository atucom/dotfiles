#!/bin/bash

#the absolute path of this script
source_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $(uname) = "Darwin" ]]; then #this is for OSX Machines
    md5_bin="md5"
fi
if [[ $(uname) = "Linux" ]]; then #this is for Linux
    md5_bin="md5sum"
fi

#link the files in the confs dir to dest_conf_dir
for i in $source_path/confs/*; do 
    basename_file="$(basename $i)"
    dest_conf_dir="$HOME"
    dest_path="$dest_conf_dir/${basename_file/_/.}"
    source_file="$i"
    if [[ -f $dest_path ]]; then #if the dest_path exists then
        if [[ $(cat "$dest_path" | "$md5_bin") = $(cat "$source_file" | "$md5_bin") ]]; then #if the file is the same
            echo "$dest_path is already the same"
        else
            echo backing up ${dest_path} to ${dest_path}.bak
            cp ${dest_path} ${dest_path}.bak
        fi
    else
        ln -s $i "$dest_conf_dir"/${basename_file/_/.}
    fi
done

#Special Installation Steps
