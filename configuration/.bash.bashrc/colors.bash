#!/usr/bin/env bash

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
