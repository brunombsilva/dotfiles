#!/usr/bin/env bash

# include current folder in path
export PATH=$PATH:.

# include user binaries
export PATH=$PATH:~/.dotfiles/bin/:~/bin

export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export NVM_DIR="$HOME/.nvm"


export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.cargo/bin

#binaries resulting from pip install --user <package>
export PATH=$PATH:$HOME/.local/bin

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
