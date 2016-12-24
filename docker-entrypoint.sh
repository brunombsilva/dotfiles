set -e
echo "${USER_PUBLIC_KEY}" > $HOME/.ssh/authorized_keys

sudo /usr/sbin/sshd -e -D
