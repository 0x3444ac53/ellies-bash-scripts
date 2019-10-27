search(){
    url='https://google.com/search?q=%s'
    searchoptions=''
    if [ "${1:0:1}" = "-" ]; then
        case $1 in
            "-y")
                url='https://www.youtube.com/results?q=%s'
                shift
                ;;
            "-r")
                searchoptions="+site:www.reddit.com"
                shift
                ;;
            "-w")
                url='https://en.wikipedia.org/w/index.php?search=%s'
                shift
                ;;
            "-od")
                searchoptions='+intitle%3A%22index+of%22+-inurl%3A%28jsp%7Cpl%7Cphp%7Chtml%7Caspx%7Chtm%7Ccf%7Cshtml%29+-inurl%3A%28hypem%7Cunknownsecret%7Csirens%7Cwriteups%7Ctrimediacentral%7Carticlescentral%7Clisten77%7Cmp3raid%7Cmp3toss%7Cmp3drug%7Ctheindexof%7Cindex_of%7Cwallywashis%7Cindexofmp3%29'
                shift
                 ;;
        esac
    fi
    echo "$*" > searchy
    surf "$(printf "$url" "$(sed -e 's/ /+/g' searchy)")$searchoptions" 2>/dev/null &
}
