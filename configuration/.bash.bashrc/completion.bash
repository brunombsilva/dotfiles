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

if type complete &>/dev/null; then
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
fi

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
