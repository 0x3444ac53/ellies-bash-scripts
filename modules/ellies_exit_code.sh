
ellies_exit_code(){
    #OVERRIDE 
    [[ $RETVAL == false ]] && return
    case $1 in
        127)
             SPACESHIP_EXIT_CODE_SYMBOL='ᕙ(⇀‸↼‶)ᕗ '
            ;;
        126)
            SPACESHIP_EXIT_CODE_SYMBOL='(╯°□°）╯︵ ┻━┻ '
            ;;
        2)
            SPACESHIP_EXIT_CODE_SYMBOL='( •_•) '
            ;;
        *)
             SPACESHIP_EXIT_CODE_SYMBOL='$?= '
    esac
    spaceship::section \
        "$SPACESHIP_EXIT_CODE_COLOR" \
        "$SPACESHIP_EXIT_CODE_PREFIX" \
        "${SPACESHIP_EXIT_CODE_SYMBOL}$RETVAL" \
        "$SPACESHIP_EXIT_CODE_SUFFIX"
}
