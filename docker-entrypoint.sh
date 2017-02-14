#!/bin/bash

set -e

if [ "$1" == '/usr/sbin/sshd' ]; then
    echo "${USER_PUBLIC_KEY}" > /home/$USER_NAME/.ssh/authorized_keys
    su-exec root "$@"
else
    echo "$@" | su-exec $USER_NAME /bin/bash -i -s
fi

