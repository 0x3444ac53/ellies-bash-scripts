ellie_screen_shot(){
    dest="/home/ellie/Pictures/ScreenShots/scrot_$(date +'%s').png"
    case $1 in
        "--current-dir")
            dest="$(pwd)/scrot_$(date +'%s').png"
            shift 
            ;;
    esac
    scrot "$dest"
    notify-send -t 1000 "$dest"
}
