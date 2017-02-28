
export POWERLINE_CONFIG_OVERRIDES='ext.shell.theme=default'

if [ -z "$POWERLINE_LOCATION" ]; then
    export POWERLINE_LOCATION=`pip show powerline-status | grep Location | sed -e 's/Location: //'`/powerline
    powerline-daemon -q
fi
source "$POWERLINE_LOCATION/bindings/zsh/powerline.zsh"
