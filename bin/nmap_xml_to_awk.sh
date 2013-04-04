#!/bin/bash
    if [[ -z $1 ]]; then
        echo 'Converts the specified nmap xml files to a easily grep/awk-able format' #or the builtin of ssh-keygen -R hostname
        echo "Usage: $0 <nmap_scan.xml>"
    else
        xmlstarlet sel -T -t -m "//state[@state='open']" -m ../../.. -v address/@addr -o '   (' -m hostnames/hostname[1] -v @name -b -o ')' -b -o "   " -m .. -v @portid -o '/' -v @protocol -o "   " -m service -v @name -o " " -v @product -o " " -v @version -v @extrainfo -b -n $1
fi