#!/usr/bin/env bash

if [ -z "$POWERLINE_LOCATION" ]; then
    export POWERLINE_LOCATION=`pip show powerline-status | grep Location | sed -e 's/Location: //'`/powerline
    powerline-daemon -q
fi

POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source "$POWERLINE_LOCATION/bindings/bash/powerline.sh"

# Hammer time! shell input will start in the line after powerline
#PROMPT_COMMAND="$PROMPT_COMMAND"$'\n''PS1="$PS1\n "'
PROMPT_COMMAND="$PROMPT_COMMAND"$'\n''ssh_auth_sock'
