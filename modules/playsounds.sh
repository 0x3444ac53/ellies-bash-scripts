#!/bin/zsh
playsounds(){
  mpv --no-video \
    $(youtube-dl -j --flat-playlist "$1" \
    | jq -r '.title + "   :" +.id' \
    | fzf \
    | cut -d ':' -f2 \
    | xargs printf 'https://www.youtube.com/watch?v=%s')
}

if [[ $ZSH_EVAL_CONTEXT == 'toplevel' ]]; then
  playsounds "$@"
fi

