#!/bin/bash
    if [[ -z $1 ]]; then
        echo 'Simple Calculator'
        echo "Usage: $0 4*67 "
    else
        awk "BEGIN{ print $* }"
    fi;