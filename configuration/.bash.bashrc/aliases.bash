#!/usr/bin/env bash

# enable color support of ls and also add handy aliases

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    case "$OSTYPE" in
        darwin*) alias ls='ls -G' ;;
        *) alias ls='ls --color=auto' ;;
    esac

    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# GIT
alias gb='git branch --color'
alias gba='git branch --color -a'
alias gc='git commit -v'
alias gst='git status'
alias gco='git checkout'
alias gpush='git push'
alias gpull='git pull'
alias gadd='git add -i'
alias gmerge='git merge'
alias gd='git diff HEAD'


# HTTP serve current folder
alias likeabossHTTP='python -c "import SimpleHTTPServer;SimpleHTTPServer.test()" &'

# Check PHP files syntax recursively in current folder
alias php_syntax='find ./ -type f -name \*.php -exec php -l {} \; | grep -v "^No syntax errors detected in"'

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# View HTTP traffic
alias sniff="sudo ngrep -d 'eth0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i eth0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""


# Current Memory Usage
alias mem-used="top -b -n 1 | grep -Po '(?<=Mem:).*free' | sed 's/ *\([0-9]*\)k total, *\([0-9]*\)k used, *\([0-9]*\)k free/Mem: \3 \/ \1/'"

# Make current directory readable for all users
alias readable="chmod -R a+r .; find . -type d -exec chmod a+xr {} \;"

alias weather="curl -4 http://wttr.in/"
