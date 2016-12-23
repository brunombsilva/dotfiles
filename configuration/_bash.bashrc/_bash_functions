#!/usr/bin/env bash

# From: https://github.com/holman/dotfiles/blob/master/functions/extract

# credit: http://nparikh.org/notes/zshrc.txt
# Usage: extract <file>
# Description: extracts archived files / mounts disk images
# Note: .dmg/hdiutil is Mac OS X-specific.
extract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf $1                        ;;
            *.tar.gz)   tar -zxvf $1                        ;;
            *.bz2)      bunzip2 $1                          ;;
            *.dmg)      hdiutil mount $1                    ;;
            *.gz)       gunzip $1                           ;;
            *.tar)      tar -xvf $1                         ;;
            *.tbz2)     tar -jxvf $1                        ;;
            *.tgz)      tar -zxvf $1                        ;;
            *.zip)      unzip $1                            ;;
            *.ZIP)      unzip $1                            ;;
            *.pax)      cat $1 | pax -r                     ;;
            *.pax.Z)    uncompress $1 --stdout | pax -r     ;;
            *.Z)        uncompress $1                       ;;
            *)          echo "'$1' cannot be extracted/mounted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Update tmux pane environment variables after attaching session. Usefull for $SSH_AUTH_SOCK
tmup () 
{ 
    echo -n "Updating to latest tmux environment...";
    export IFS=",";
    for line in $(tmux showenv -t $(tmux display -p "#S") | tr "\n" ",");
    do
        if [[ $line == -* ]]; then
            unset $(echo $line | cut -c2-);
        else
            export $line;
        fi;
    done;
    unset IFS;
    echo "Done"
}


ssh_auth_sock ()
{
    if [ ! -f $SSH_AUTH_SOCK ]; then
        export SSH_AUTH_SOCK=$(find /tmp/ssh-* -user `whoami` -name agent\* -printf '%T@ %p\n' 2>/dev/null | sort -k 1nr | sed 's/^[^ ]* //' | head -n 1)
    fi
}

# Modified version of what `composer _completion -g -p composer` generates
# Composer will only load plugins when a valid composer.json is in its working directory,
# so  for this hack to work, we are always running the completion command in ~/.composer
function _composercomplete {
    export COMP_LINE COMP_POINT COMP_WORDBREAKS;
    local -x COMPOSER_CWD=`pwd`
    local RESULT STATUS

    # Honour the COMPOSER_HOME variable if set
    local composer_dir=$COMPOSER_HOME
    if [ -z "$composer_dir" ]; then
        composer_dir=$HOME/.composer
    fi

    RESULT=`cd $composer_dir && composer depends _completion`;
    STATUS=$?;

    if [ $STATUS -ne 0 ]; then
        echo $RESULT;
        return $?;
    fi;

    local cur;
    _get_comp_words_by_ref -n : cur;

    COMPREPLY=(`compgen -W "$RESULT" -- $cur`);

    __ltrim_colon_completions "$cur";
};
complete -F _composercomplete composer;

###-begin-bower-completion-###
if type complete &>/dev/null; then
  _bower_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           bower-complete completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _bower_completion bower
fi
###-end-bower-completion-###
