#!/usr/bin/env bash
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

unset color_prompt force_color_prompt

for f in ~/.bash.bashrc/*; do source $f; done

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# include current folder in path
export PATH=$PATH:.

export LANG=en_US.UTF-8

# include user binaries
export PATH=$PATH:~/.dotfiles/bin/

# default editor
export EDITOR="vim"
export SVN_EDITOR='vim'

# git author data comes from .gitconfig and is saved as environment variables
# that are sent to ssh connections to maintain you identity across machines
export GIT_AUTHOR_NAME=`git config user.name`
export GIT_AUTHOR_EMAIL=`git config user.email`
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"


# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# term type stuff... I don't really remember anyhing about this.
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
   export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
   export TERM=xterm-256color
fi

# Local color variables
if tput setaf 1 &> /dev/null; then
   tput sgr0
   if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
       ORANGE=$(tput setaf 172)
       GREEN=$(tput setaf 70)
       PURPLE=$(tput setaf 141)
       WHITE=$(tput setaf 256)
   else
       ORANGE=$(tput setaf 4)
       GREEN=$(tput setaf 2)
       PURPLE=$(tput setaf 1)
       WHITE=$(tput setaf 7)
   fi
   BOLD=$(tput bold)
   RESET=$(tput sgr0)
else
   ORANGE="\033[1;33m"
   GREEN="\033[1;32m"
   PURPLE="\033[1;35m"
   WHITE="\033[1;37m"
   BOLD=""
   RESET="\033[m"
fi

export ORANGE
export GREEN
export WHITE
export BOLD
export RESET


# Highlight section titles in manual pages
export LESS_TERMCAP_md="$GREEN"

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

export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm


export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.cargo/bin

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


# tabtab source for bower package
# uninstall by removing these lines or running `tabtab uninstall bower`
[ -f /usr/lib/node_modules/bower-complete/node_modules/tabtab/.completions/bower.bash ] && . /usr/lib/node_modules/bower-complete/node_modules/tabtab/.completions/bower.bash


# prompt configuration (PS1, etc) is stored in a different file
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi
