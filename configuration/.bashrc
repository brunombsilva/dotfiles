#!/usr/bin/env bash
# ~/.bashrc: executed by bash(1) for non-login shells.

#for f in ~/.bash.bashrc/*; do source $f; done
. ~/.bash.bashrc/path.bash

eval "$(rbenv init -)"
eval "$(pyenv init -)"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

. ~/.bash.bashrc/colors.bash
. ~/.bash.bashrc/aliases.bash
. ~/.bash.bashrc/docker.bash
. ~/.bash.bashrc/functions.bash
. ~/.bash.bashrc/env.bash

# If not running interactively, don't do anything more
[ -z "$PS1" ] && return

. ~/.bash.bashrc/completion.bash
. ~/.bash.bashrc/git-completion.bash
. ~/.bash.bashrc/tmuxinator.bash


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

# http://zameermanji.com/blog/2012/12/30/using-vim-as-manpager/
#export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

. ~/.bash.bashrc/prompt.bash
