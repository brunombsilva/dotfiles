#!/usr/bin/env bash

#Assuming tput + 256 colors available

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

