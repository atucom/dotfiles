#!/bin/bash

#the absolute path of this script
source_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $(uname) = "Darwin" ]]; then #this is for OSX Machines
    md5_bin="md5sum -q "
fi
if [[ $(uname) = "Linux" ]]; then #this is for Linux
    md5_bin="md5 --quiet "
fi

#link the files in the confs dir to dest_conf_dir
for i in $source_path/confs/*; do 
    basename_file=$(basename $i)
    dest_conf_dir="$HOME"
    dest_path="$dest_conf_dir/${basename_file/_/.}"
    source_file="$i"
    if [[ -f $dest_path ]]; then #if the dest_path exists then
        if [[ $($md5_bin $dest_path) = $($md5_bin $source_file) ]]; then #if the file is the same
            echo "$dest_path is already the same"
        else
            echo backing up ${dest_path} to ${dest_path}.bak
            cp ${dest_path} ${dest_path}.bak
        fi
    else
        ln -s $i "$dest_conf_dir"/${basename_file/_/.}
    fi
done




#check if it exists
#    yes: are they the same file? ($md5_bin)
#        yes: echo "same file, nothing done"
#        no: backup the file to $name.bak0
#            echo "backed up file to $name.bak0"
#    no: link the file
#
#check if $HOME/scripts exists in $path
#    yes: does the scripts/ dir contain the links?
#        yes: echo bins already linked, nothing to do
#        no: move the bins into the dir
#    no: create it and link bin/ files into it