
if [ -s "$(which wsl.exe)" ]; then
    unsetopt BG_NICE
    . ~/.bash.bashrc/wsl.bash
fi

. ~/.bash.bashrc/aliases.bash
. ~/.bash.bashrc/functions.bash
. ~/.bash.bashrc/colors.bash
. ~/.bash.bashrc/path.bash
. ~/.bash.bashrc/env.bash

source ~/.zsh.zshrc/antigen.zsh
antigen init ~/.antigenrc

fpath[1,0]=~/.zsh/completion/

source ~/.zsh.zshrc/prompt.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/brunombsilva/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/brunombsilva/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/brunombsilva/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/brunombsilva/google-cloud-sdk/completion.zsh.inc'; fi
