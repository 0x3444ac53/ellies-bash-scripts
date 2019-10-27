play_youtube_audio(){
    mpv --no-video ${$(youtube-dl -g ytsearch1:"$1" 2>/dev/null)[2]}
}
play_youtube_video(){
    info=("${(@f)$(youtube-dl -g ytsearch":$1" 2>/dev/null)}")
    mpv "${info[1]}" --audio-file="${info[2]}"
}
