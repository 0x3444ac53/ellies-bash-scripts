ellie_screen_shot(){
    dest="/home/ellie/Pictures/ScreenShots/scrot_$(date +'%s').png"
    scrot "$dest"
    notify-send -t 1000 "$dest"
}
