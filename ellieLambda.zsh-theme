PROMPT='%(?..[$(ellies_exit_code $?)])⌂ %(4~|.../%3~|%~) $(git_prompt_info)%{$reset_color%}'

ellies_exit_code(){
    #OVERRIDE 
    #[[ $RETVAL == false ]] && return
    echo "$@" > '/home/ellie/test.txt'
    case $1 in
        127)
             echo 'ᕙ(⇀‸↼‶)ᕗ '
            ;;
        126)
            echo '(╯°□°）╯︵ ┻━┻ '
            ;;
        130)
            echo '😱'
            ;;
        2)
            echo '( •_•) '
            ;;
        *)
             echo '$?='$1
    esac
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
