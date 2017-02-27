
export LANG=en_US.UTF-8

# default editor
export EDITOR="vim"
export SVN_EDITOR='vim'

# git author data comes from .gitconfig and is saved as environment variables
# that are sent to ssh connections to maintain you identity across machines
export GIT_AUTHOR_NAME=`git config user.name`
export GIT_AUTHOR_EMAIL=`git config user.email`
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

