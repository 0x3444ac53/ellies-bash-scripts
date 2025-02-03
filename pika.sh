#!/bin/env zsh

# or use wm array -- add any that need to be recognized
wms=( sowm 2bwm 2wm 9wm aewm afterstep ahwm alopex amiwm antiwm awesome berry blackbox bspwm catwm clfswm ctwm cwm dminiwm dragonflywm dwm echinus \
  euclid-wm evilpoison evilwm fluxbox flwm fvwm-crystal goomwwm hcwm herbstluftwm i3 icewm jwm karmen larswm lwm matwm2 mcwm monsterwm \
  musca notion nwm olwm openbox oroborus pekwm ratpoison sapphire sawfish sscrotwm sithwm smallwm snapwm spectrwm stumpwm subtle tfwm tinywm tritium twm \
  uwm vtwm w9wm weewm wind windowlab wm2 wmaker wmfs wmii wmx xfwm4 xmonad xoat yeahwm )

# define colors for color-echo
red="\033[31m"
grn="\033[32m"
ylw="\033[33m"
cyn="\033[36m"
blu="\033[34m"
prp="\033[35m"
bprp="\033[35;1m"
rst="\033[0m"

color-echo()
{  # print with colors
  echo -e " $prp$1: $rst$2"
}

print-kernel()
{
  color-echo 'KL' "$(uname -smr)"
}

print-colours(){
  for i in {31..37}
  do
    echo -ne "\033[${i};7m   "
  done
  echo -e "\033[0m"
  for i in {91..97}
  do
    echo -ne "\033[${i};7m   "
  done
  echo -e "\033[0m"
}

print-hostname()
{
    color-echo 'HOST' "$(hostname)"
}

print-uptime()
{
  up=$(</proc/uptime)
  up=${up//.*}                # string before first . is seconds
  days=$((${up}/86400))       # seconds divided by 86400 is days
  hours=$((${up}/3600%24))    # seconds divided by 3600 mod 24 is hours
  mins=$((${up}/60%60))       # seconds divided by 60 mod 60 is mins
  color-echo "UP" $days'd '$hours'h '$mins'm'
}

print-shell() {
  color-echo 'SH' "$(echo $SHELL)"
}

print-cpu()
{
  arm=$(grep ARM /proc/cpuinfo)    # ARM procinfo uses different format
  if [[ "$arm" != "" ]]; then
    cpu=$(grep -m1 -i 'Processor' /proc/cpuinfo)
  else
    cpu=$(grep -m1 -i 'model name' /proc/cpuinfo)
  fi
  color-echo 'CP' "${cpu#*: }" # everything after colon is processor name
}

print-gpu()
{
  gpu=$(lspci | grep VGA | awk -F ': ' '{print $2}' | sed 's/(rev ..)//g')
  color-echo 'GP' "$gpu"
}

print-packages()
{
  packages=$(apt list --installed 2>/dev/null | wc -l)
  color-echo 'PKG' "$packages"
}

print-wm()
{
  for wm in ${wms[@]}; do          # pgrep through wmname array
    pid=$(pgrep -x -u $USER $wm) # if found, this wmname has running process
    if [[ "$pid" ]]; then
      color-echo 'WM' $wm
      wm_set=0
      break
    fi
  done
  if [[ ! "$pid" ]]; then
      color-echo 'WM' "TTY"
  fi
}

print-song(){
    color-echo "PLAYING" "$(mpc current -f "%title%")"
}

print-artist(){
    color-echo "BY" "$(mpc current -f "%artist%")"
}
print-album(){
    color-echo "FROM" "$(mpc current -f "%album%")"
}

print-spotsong(){
    color-echo "PLAYING" "$(spotify-now -i "%title")"
}

print-spotartist(){
    color-echo "BY" "$(spotify-now -i "%artist")"
}

print-spotalbum(){
    color-echo "FROM" "$(spotify-now -i "%album")"
}

print-distro()
{
  [[ -e /etc/os-release ]] && source /etc/os-release
  if [[ -n "$PRETTY_NAME" ]]; then
    color-echo 'OS' "$PRETTY_NAME"
  else
    color-echo 'OS' "not found"
  fi
}

echo -en "        " && color-echo "USER" "Ellie"
echo -en "        " && print-hostname
echo -en "$ylw\    /\  $rst " && print-wm
echo -en "$ylw )  ( ') $rst " && print-shell
echo -en "$ylw(  /  )  $rst" && print-packages
echo -en "$ylw \(__)|  $rst " && print-uptime
if [[ ! -z "$(pgrep -x mpd)" ]] && [[ ! -z "$(mpc current)" ]]; then
    echo -en "" && print-song
    echo -en "   " && print-album
    echo -en "     " && print-artist
elif [[ ! -z "$(pgrep -x spotify)" ]]; then
    echo -en "" && print-spotsong
    echo -en "   " && print-spotalbum
    echo -en "     " && print-spotartist

fi
print-colours
