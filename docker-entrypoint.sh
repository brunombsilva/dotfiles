#!/bin/bash

set -e

HOME=/home/$USER_NAME

if [ "$1" == '/usr/sbin/sshd' ]; then
    echo "${USER_PUBLIC_KEY}" > ~/.ssh/authorized_keys
    su-exec root "$@"
else
    source ~/.bashrc
    su-exec $USER_NAME "$@"
fi

