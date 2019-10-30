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
    walldir=$(cat /home/ellie/.config/rendom_bg/'dirs' | shuf -n 1)
    echo "$walldir/$(ls $walldir | shuf -n 1)"
}
add_favourite_background(){
    grep -Fxq "$image" /home/ellie/bin/favourite\ png\'s.txt && echo "image saved" || echo $image >> /home/ellie/bin/favourite\ png\'s.txt 
}
