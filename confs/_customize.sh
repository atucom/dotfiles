#!/bin/bash
####################COLORS!
if [[ $- == *i* ]]; then #do colors if shell is interactive
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    LIME_YELLOW=$(tput setaf 190)
    POWDER_BLUE=$(tput setaf 153)
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    WHITE=$(tput setaf 7)
    BRIGHT=$(tput bold)
    NORMAL=$(tput sgr0)
    BLINK=$(tput blink)
    REVERSE=$(tput smso)
    UNDERLINE="$(tput smul)"
fi
#you have to place \[ \] around colors so it doesnt mess up word wrapping on the prompt
export PS1='\[${RED}\][\[${BRIGHT}\]\[${MAGENTA}\]\t\[${NORMAL}\]\[${RED}\]][\[${BLUE}\]\u\[${RED}\]\[${RED}\]]@[\[${CYAN}\]\h\[${RED}\]:\[${NORMAL}\]\w\[${RED}\]]\$\[${NORMAL}\] '
export HISTTIMEFORMAT="%F %T "
export HISTSIZE=1000000
export HISTCONTROL=ignoredups
export PROMPT_COMMAND='history -a'
shopt -s histappend

#OS Independent Aliases
alias ccat='pygmentize -g'
alias celar=clear
alias claer=clear
alias lear=clear
alias c=clear
alias pythong=python
alias namp=nmap
alias sudo='sudo '
alias l='ls -lGh'
alias la='ls -lhGa'
alias lsr='l -Sr'
alias ltr='l -tr'
alias pgg='ping google.com'
alias p4='ping 4.2.2.2'
alias cmx="chmod +x"
alias sr="screen -r"
alias sl='screen -ls'
alias httpserver='python -m SimpleHTTPServer'
alias rsynccopy="rsync --partial --progress --append --rsh=ssh -r -h "
alias rsyncmove="rsync --partial --progress --append --rsh=ssh -r -h --remove-sent-files"
alias git_send="git add * && git commit -a && git push origin master"
alias gpom="git push origin master"
alias atu-clean-shell='oldps1=$PS1;PS1=\$'
alias atu-normal-shell='PS1=$oldps1'
alias bpy=bpython
alias last-modified="find . -type f -exec stat --format '%y : %s : %n' {} \; | sort -nr"
alias curl-firefox='curl -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10; rv:33.0) Gecko/20100101 Firefox/33.0"'
alias curl-chrome='curl -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36"'
alias curl-ie='curl -A "Mozilla/4.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/5.0)"'
alias curl-iphone='curl -A "Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25"'
alias curl-android='curl -A "Mozilla/5.0 (Linux; U; Android 4.0.3; ko-kr; LG-L160L Build/IML74K) AppleWebkit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"'
alias ps?='ps aux | grep '
lpwd(){
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")" #stolen from stack overflow
}



#MAC OSX SPECIFIC CODE
if [[ $(uname) = "Darwin" ]]; then #this is for OSX Machines
    alias ntlp="lsof -Pn -i | grep -E '(UDP|LISTEN|ESTABLISHED)' | awk '{print \$10, \$1, \$8, \$9}' | column -t | sort" #netstat -ntulp
    alias updatedb='sudo /usr/libexec/locate.updatedb'
    alias sublime="open -a \"/Applications/Sublime Text 2.app\""
    def_int=$(route -n get default | grep interface | awk '{print $2}')
    def_int_ip=$(ifconfig ${def_int} | grep 'inet ' | awk '{print $2}')
    #This sets up auto logging to $HOME/logs if its a tmux window
    #if [[ $TERM = "screen" ]] && [[ $(ps $PPID -o comm=) = "tmux" ]] ; then
    #    read -p "Enter Log Prefix: " log_prefix
    #    logname="${log_prefix}_$(date '+%d.%m.%Y-%H:%M:%S').tmux.log"
    #	mkdir -p logs/screen.sessions
    #    exit
    #fi
fi

#LINUX SPECIFIC CODE
if [[ $(uname) = "Linux" ]]; then #this is for Linux
    alias agu='apt-get update'
    alias agi='apt-get install'
    alias agg='apt-get upgrade'
    alias ntlp='netstat -ntlup'
    def_int=$(route -n | grep '^0.0.0.0.* UG ' | awk '{print $8}')
    def_int_ip=$(ifconfig ${def_int} | grep 'inet ' | awk '{print $2}' | cut -d':' -f 2)
    #if [[ $TERM = "screen" ]] && [[ $(ps -p $PPID -o comm=) = "tmux" ]]; then
    #    read -p "Enter Log Prefix: " log_prefix
    #    logname="${log_prefix}_$(date '+%d.%m.%Y-%H:%M:%S').tmux.log"
    #    mkdir $HOME/logs 2> /dev/null
    #    script -f $HOME/logs/${logname}
    #    exit
    #fi
fi
