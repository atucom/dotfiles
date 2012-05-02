#Typo aliases
alias celar=clear
alias claer=clear
alias namp=nmap
alias lear=clear

#reduce the need to type frequently used commands
alias l='ls -lGh'
alias la='ls -lhGa'
alias lsr='l -Sr'
alias agu='apt-get update'
alias agi='apt-get install'
alias agg='apt-get upgrade'
alias ntlp='netstat -ntulp'
alias cd..='cd ..'
alias s='sudo '
alias c=clear
alias pgg='ping google.com'
alias p4='ping 4.2.2.2'
alias resolv='cat /etc/resolv.conf'
alias agi='apt-get install'
alias agu='apt-get update'
alias agg='apt-get upgrade'
alias cuts='cut -d " " ';
alias r=ruby
alias cmx="chmod +x"
alias p=python
alias 'ps?'='ps aux | grep'
alias nr='netstat -nr'
alias sr="screen -r"
alias sl='screen -ls'
alias netstatt='lsof -Pan -i tcp -i udp'

#pipe output to 'pastebin' to upload it somewhere and then have a link sent back to you
alias pastebin="curl -F 'sprunge=<-' http://sprunge.us"


#play the star trek engine noise for fun :)
alias engage='play -n -c1 synth whitenoise lowpass -1 120 lowpass -1 120 lowpass -1 120 gain +14'
#quick http server in pythong that shares the current directory
alias httpserver='python -m SimpleHTTPServer'
alias rsynccopy="rsync --partial --progress --append --rsh=ssh -r -h "
alias rsyncmove="rsync --partial --progress --append --rsh=ssh -r -h --remove-sent-files"

#functions be living here yar
exclude-1-from-2() {
    if [[ -z $1 ]]; then
        echo 'Deletes the entries in "exclude-list" from the entries in "target-list"'
        echo 'Usage: exclude-1-from-2 "exclude-list" "target-list"'
    else
        for i in $(cat $1); do sed -i "/$i/d" $2; done
    fi; }
ssh-del-line() {
    if [[ -z $1 ]]; then
        echo 'Deletes the specified linenumber from ~/.ssh/known_hosts'
        echo 'Usage: ssh-del-line linenumber'
    else
        sed -i "/$1/d" ~/.ssh/known_hosts
    fi; }
calc() { 
    if [[ -z $1 ]]; then
        echo 'Simple Calculator using AWK'
        echo 'Usage: calc 4*67 '
    else
        awk "BEGIN{ print $* }" 
    fi; }
