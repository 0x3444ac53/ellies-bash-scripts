get_music(){
    local currentDir=$(pwd)
    local artist="$1"
    local album="$2"
    local url="$3"
    cd /home/ellie/music 
    cd "$artist" || mkcdir "$artist"
    cd "$album" || mkcdir "$album"
    youtube-dl -x --audio-format mp3 -o "%(playlist_index)s - %(playlist_title)s - %(title)s.%(ext)s" "$url"
    cd "$currentDir"
}
mkcdir(){
    mkdir "$1"
    cd "$1"
}
