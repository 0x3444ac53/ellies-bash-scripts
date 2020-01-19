function search {
    local searchTerm
    local site
    site="https://google.com/search?q="
    if [[ "$1" == -* ]]; then
        case $1 in
            "-y"|"--youtube")
                site="https://www.youtube.com/results?search_query="
                ;;
            "-g"|"--google")
                site="https://www.google.com/search?q="
                ;;
            *)
                echo "unrecognised "$1""
                ;;
        esac
        shift
    fi
    if [[ "$*" == "" ]]; then
        searchTerm=$(dmenu -p "Search: " < <())
    else
        searchTerm="$*"
    fi
    firefox "$(printf "${site}%s" "$(echo "$searchTerm" | tr ' ' '+')")" &
}
