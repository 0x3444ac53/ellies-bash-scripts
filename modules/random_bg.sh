set_bg(){
    image=$1
    feh --bg-fill "$image"
    echo $image > /home/ellie/.wallpaper
    echo $image
    wal -i "$image" --backend colorz
    touch /home/ellie/repos/st/config.h
    sudo make install -C /home/ellie/repos/st/
    st -e pika.sh
}
cycle_folder(){
    for i in $(ls $1)
    do set_bg $1/$i
        wal -i "$image"
        read t
    done
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
}
get_random_image(){
    walldir=$(cat /home/ellie/.config/rendom_bg/'dirs' | shuf -n 1)
    echo "$walldir/$(ls $walldir | shuf -n 1)"
}
add_favourite_background(){
    image=$(cat /home/ellie/.wallpaper | head -n 1)
    grep -Fxq $image /home/ellie/bin/favourite\ png\'s.txt && echo "image already saved" || echo $image >> /home/ellie/bin/favourite\ png\'s.txt
}
remove_favourite_background(){
    sed "s:$(cat /home/ellie/.wallpaper): :g" "/home/ellie/bin/favourite png's.txt"
    sed "/^ /d" "/home/ellie/bin/favourite png's.txt"
}
