set_bg(){
    image=$1
    feh --bg-fill "$image"
}
random_bg(){
    image=$(get_random_image)
    case $1 in
        "-p")
            image="$2/$(ls $2 | shuf -n 1)"
            ;;
        "-f")
             image="$(cat /home/ellie/bin/favourite\ png\'s.txt | shuf -n 1)"
            ;;
    esac
    set_bg $image
    echo $image
}
get_random_image(){
    wallpaperdirs=('/home/ellie/bin/rips/imgur_rMPdm_1000_Spectacular_Wallpapers_1080p_unmarked' '/home/ellie/bin/rips/imgur_Wn9ec5u_HUGE_Wallpaper_Dump_of_Art_Movies_and_etc' '/home/ellie/bin/rips/Minimal_and_abstract_wallpapers_for_you._and_you._and_you_too.' "/home/ellie/bin/rips/imgur_rG2L6_830_Backgrounds_mostly_1280x800_or_greater_enjoy_xxxx" "/home/ellie/bin/rips/imgur_ONTjY_Quick_cyberpunk_wallpaper_dump" "/home/ellie/bin/rips/imgur_rBarn_Wallpaper_dump_-_1920x1080_or_higher")
    num=$[$RANDOM % ${#wallpaperdirs[@]}]
    walldir=${wallpaperdirs[$[num + 1]]}
    echo "$walldir/$(ls $walldir | shuf -n 1)"
}
add_favourite_background(){
    grep -Fxq "$image" /home/ellie/bin/favourite\ png\'s.txt && echo "image saved" || echo $image >> /home/ellie/bin/favourite\ png\'s.txt 
}
