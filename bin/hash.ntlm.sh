#!/bin/bash
    
    if [[ -z $1 ]]; then
        echo 'Calculate NTLM hash from stdin'
        echo "Usage: $0 <string>  "
    else
        iconv -f UTF-8 -t UTF-16LE <(printf "$1") | openssl dgst -md4;
    fi;