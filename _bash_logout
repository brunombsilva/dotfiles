# Find the newest SSH agent that's not the one from this session
find /tmp -name agent.* -user $USER -exec stat -f '%c %N' {} \; 2>/dev/null \
        | sort -n \
        | while read CTIME NAME; do
        if [ "$NAME" != "$SSH_AUTH_SOCK_OLD" ]; then
                # Check if this socket is alive and working
                SSH_AUTH_SOCK=$NAME ssh-add -l >/dev/null 2>&1
                if [ $? -eq 0 ]; then
                        ln -sf $NAME ~/.ssh/auth/sock
                        unset SSH_AUTH_SOCK_OLD
                fi
                break
        fi
done

# If $SSH_AUTH_SOCK_OLD is still set, it did not work out. Remove the symlink
if [ -n "$SSH_AUTH_SOCK_OLD" ]; then
    rm ~/.ssh/auth/sock
fi
