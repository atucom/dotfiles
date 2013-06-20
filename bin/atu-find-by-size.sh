#!/bin/bash
#list files in current dir by file size
#!/bin/bash
    if [[ -z $1 ]]; then
        echo 'Find files in current directory that are the specified size'
        echo "Usage: $0 +10M"
    else
        find . -maxdepth 1 -type f -size ${1} -exec basename {} \;
    fi