#!/bin/bash    
    if [[ -z $1 ]] || [[ -z $2 ]]; then
        echo 'Expands nmap compatible ranges from the first file into the second file'
        echo "Usage: $0 <CIDRFile> <OutputFile> "
    else
        nmap -sL -n -iL $1 | grep 'Nmap scan' | cuts -f 5 > $2
    fi;