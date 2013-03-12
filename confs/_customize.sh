#!/bin/bash
####################COLORS!
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
#you have to place \[ \] around colors so it doesnt mess up word wrapping on the prompt
export PS1='\[${RED}\][\[${BRIGHT}\]\[${MAGENTA}\]\t\[${NORMAL}\]\[${RED}\]][\[${BLUE}\]\u\[${RED}\]\[${RED}\]]@[\[${CYAN}\]\h\[${RED}\]:\[${NORMAL}\]\w\[${RED}\]}\$\[${NORMAL}\] '
export HISTTIMEFORMAT="%F %T "
export HISTSIZE=1000000
export PROMPT_COMMAND='history -a; history -n'
shopt -s histappend

#OS Independent Aliases
alias celar=clear
alias claer=clear
alias namp=nmap
alias lear=clear
alias c=clear
alias sudo='sudo '
alias l='ls -lGh'
alias la='ls -lhGa'
alias lsr='l -Sr'
alias pgg='ping google.com'
alias p4='ping 4.2.2.2'
alias cmx="chmod +x"
alias sr="screen -r"
alias sl='screen -ls'
alias httpserver='python -m SimpleHTTPServer'
alias rsynccopy="rsync --partial --progress --append --rsh=ssh -r -h "
alias rsyncmove="rsync --partial --progress --append --rsh=ssh -r -h --remove-sent-files"

#MAC OSX SPECIFIC CODE
if [[ $(uname) = "Darwin" ]]; then #this is for OSX Machines
    alias ntlp="lsof -Pn -i | grep -E '(UDP|LISTEN|ESTABLISHED)' | awk '{print \$10, \$1, \$8, \$9}' | column -t | sort" #netstat -ntulp
    alias updatedb='sudo /usr/libexec/locate.updatedb'
    alias sublime="open -a \"/Applications/Sublime Text 2.app\""
    #This sets up auto logging to $HOME/logs if its a tmux window
    if [[ $TERM = "screen" ]] && [[ $(ps $PPID -o comm=) = "tmux" ]] ; then
        logname="$(date '+%d.%m.%Y_%H:%M:%S').tmux.log"
        mkdir $HOME/logs 2> /dev/null
        script -t 1 $HOME/logs/${logname} bash -login
        exit
    fi
fi

#LINUX SPECIFIC CODE
if [[ $(uname) = "Linux" ]]; then #this is for Linux
    alias agu='apt-get update'
    alias agi='apt-get install'
    alias agg='apt-get upgrade'
    alias ntlp='netstat -ntlup'
    if [[ $TERM = "screen" ]] && [[ $(ps -p $PPID -o comm=) = "tmux" ]]; then
        logname="$(date '+%d.%m.%Y_%H:%M:%S').tmux.log"
        mkdir $HOME/logs 2> /dev/null
        script -f $HOME/logs/${logname}
        exit
    fi
fi