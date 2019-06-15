#!/usr/bin/env bash
# ~/.bashrc: executed by bash(1) for non-login shells.

# include current folder in path
export PATH=$PATH:.

# include user binaries
export PATH=$PATH:~/.dotfiles/bin/:~/bin

#binaries resulting from pip install --user <package>
export PATH=$PATH:$HOME/.local/bin

export PATH=$PATH:$HOME/bin

export TERM=xterm-256color

tput sgr0
YELLOW="$(tput setaf 3)"
RED="$(tput setaf 160)"
BLUE="$(tput setaf 81)"
GREEN="$(tput setaf 40)"
BOLD=$(tput bold)
RESET=$(tput sgr0)

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$GREEN"

function warning { echo  "$YELLOW$@$RESET"; }
function error { echo  "$RED$@$RESET"; }
function info { echo "$BLUE$@$RESET"; }
function success { echo "$GREEN$@$RESET"; }

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# View HTTP traffic
alias sniff="sudo ngrep -d 'eth0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i eth0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Current Memory Usage
alias mem-used="top -b -n 1 | grep -Po '(?<=Mem:).*free' | sed 's/ *\([0-9]*\)k total, *\([0-9]*\)k used, *\([0-9]*\)k free/Mem: \3 \/ \1/'"

alias weather="curl -4 http://wttr.in/Lisbon"

alias vless="~/.vim/plugged/vimpager/vimpager --force-passthrough"
alias vcat="~/.vim/plugged/vimpager/vimcat"

export LANG=en_US.UTF-8

# default editor
export EDITOR="vim"
export SVN_EDITOR='vim'

# git author data comes from .gitconfig and is saved as environment variables
# that are sent to ssh connections to maintain you identity across machines
export GIT_AUTHOR_NAME=`git config user.name`
export GIT_AUTHOR_EMAIL=`git config user.email`
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

# If not bash (e.g zsh) bail out from the rest of configuration
[ ! -n "$BASH" ] && return

# If not running interactively, don't do anything more
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# ignore annoying commands from history
HISTIGNORE="pwd;exit:date:* --help:fg"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# A command name that is the name of a directory is executed as if it were the argument to the cd command.
shopt -s autocd

# The pattern '**' used in a filename expansion context will match all files and zero or more directories and subdirectories.
# If the pattern is followed by a '/', only directories and subdirectories match.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
