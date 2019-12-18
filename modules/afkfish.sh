
afkfish(){
sleep 5
for i in $(xdotool getmouselocation);
	do if [[ "${i:0:1}" = w ]]; then id=$i
	fi
done 
id="$id "; id="${id:6:-1}"; echo FOUND; sleep 5
xdotool key --window "$id" Escape 
xdotool mousedown --window "$id" 1
}
