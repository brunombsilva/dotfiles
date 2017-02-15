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

# If not running interactively, don't do anything more
[ -z "$PS1" ] && return

. ~/.bash.bashrc/completion.bash
. ~/.bash.bashrc/git-completion.bash
. ~/.bash.bashrc/prompt.bash
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

# http://zameermanji.com/blog/2012/12/30/using-vim-as-manpager/
#export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# Load https://github.com/rupa/z
# z [-chlrtx] [regex1 regex2 ... regexn]
#
# Tracks your most used directories, based on 'frecency'.
# After  a  short  learning  phase, z will take you to the most 'frecent'
# directory that matches ALL of the regexes given on the command line, in order.
# For example, z foo bar would match /foo/bar but not /bar/foo.
if [ -f ~/.rupa-z/z.sh ]; then
    . ~/.rupa-z/z.sh
fi
