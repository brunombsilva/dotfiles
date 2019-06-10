
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


if [[ "$OSTYPE" == "darwin"* ]]; then
    gcloud_path='/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
    gcloud_completion='/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

    if [ -f $gcloud_path ]; then
        source $gcloud_path
    fi
    if [ -f $gcloud_completion ]; then
        source $gcloud_completion
    fi
fi

export CLOUDSDK_PYTHON=~/.pyenv/versions/2.7.9/bin/python
