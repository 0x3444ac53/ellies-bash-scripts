pirate(){
setprevwifi
connecttopirate || return 3
if [ "$1" = "-s" ]; then
    echo "Look here you lazy fuck, the 
Internet sucks balls for no reason. So here's a fucking shell. ssh yourself, cunt"
    urxvt 2>>/dev/null
else
    surf pirate.lan 2>>/dev/null
fi
reconnecttointernet && echo "Reconnected to $t"|| return 5
}
setprevwifi(){         
t=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\' -f2)
t=${t:4}                                                           
}
connecttopirate(){
    nmcli device wifi connect PirateBox\ -\ Share\ Freely && echo "Connected to PirateBox" || return 2
}
reconnecttointernet(){
    nmcli device wifi list >> /dev/null
    nmcli device wifi connect "$t" >> /dev/null || return 4
}
