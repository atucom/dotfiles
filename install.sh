#!/bin/bash

#the absolute path of this script
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#link the files in the confs dir to dest_conf_dir
for i in $script_dir/confs/*; do 
    basename_file=$(basename $i)
    dest_conf_dir="$HOME"
    ln -s $i "$dest_conf_dir"/${basename_file/_/.}
    done



#check if it exists
#    yes: are they the same file? (md5)
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