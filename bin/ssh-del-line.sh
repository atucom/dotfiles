#!/bin/bash
    if [[ -z $1 ]]; then
        echo 'Deletes the specified linenumber from ~/.ssh/known_hosts' #or the builtin of ssh-keygen -R hostname
        echo "Usage: $0 <Line>"
    else
        sed -i "/$1/d" ~/.ssh/known_hosts
    fi;