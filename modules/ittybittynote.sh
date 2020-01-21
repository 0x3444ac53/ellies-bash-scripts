
ittybittynote(){
    firefox itty.bitty.site 2>>/dev/null &!
    echo "$(zenity --entry)" >> ~/Documents/ittybittynotes
}
readittybittynote(){
    local note
    note=$(echo $(for i in $(cat Documents/ittybittynotes); do echo ${${i##*\#}%%/*}; done) | sed 's/ /\n/g' | dmenu)
    for link in $(cat Documents/ittybittynotes); do
        if [[ "$link" == *"$note"* ]]; then 
            echo $link
        fi
    done
}
