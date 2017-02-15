#!/usr/bin/env bash

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh


#nvm completion
[ -f "$HOME/.nvm/bash_completion" ] && . "$HOME/.nvm/bash_completion"

# tabtab source for bower package
# uninstall by removing these lines or running `tabtab uninstall bower`
[ -f /usr/lib/node_modules/bower-complete/node_modules/tabtab/.completions/bower.bash ] && . /usr/lib/node_modules/bower-complete/node_modules/tabtab/.completions/bower.bash
