#!/bin/zsh
elliesearch(){
  local site
    site="https://google.com/search?q=%s"
    if [[ "$1" == -* ]]; then
        case $1 in
            "-y"|"--youtube")
                site="https://www.youtube.com/results?search_query=%s"
                ;;
            "-g"|"--google")
                site="https://www.google.com/search?q=%s"
                ;;
            "-w"|"--wikipedia")
                site="https://en.wikipedia.org/w/index.php?search=%s"
                ;;
            "-p"|"--philosophy")
                site="https://plato.stanford.edu/search/searcher.py?query=%s~"
		            pdfflag="kasldj"
                ;;
            "-lg"|"--libgen")
                site="https://libgen.is/search.php?req=%s&open=0&res=100&view=detailed"
                ;;
 	          "-al"|"--anarchist-library")
		            site="http://theanarchistlibrary.org/search?query=%s"
		            ;;
            *)
                echo "unrecognised "$1" defaulting to search engine"
                ;;
        esac
        shift
    fi
    local domain="$(echo "$site" | awk -F/ '{print $3}')"
    if [[ "$*" == "" ]]; then
	    searchTerm=$(fzf --layout=reverse --prompt="Search: " < <(_search_hist_management "$domain"))
    else
        searchTerm="$*"
    fi
    if ! [ -n "$searchTerm" ]; then
	    return 0
    fi
    _search_hist_management "$domain" "$searchTerm"
    if [ -z $pdfflag ]; then
    	google-chrome-stable "$(printf "$site" "$(echo "$searchTerm" | tr ' ' '+')")" 2>/dev/null &
    else
	    local url="$(printf "$site" "$(echo "$searchTerm" | tr ' ' '+')")"
	    eval "_asdfgh $(fzf --layout=reverse < <(echo "$url" | python3 -c "import requests; from bs4 import BeautifulSoup; url = input(); [print('\\\"' + i.find('div', {'class' : 'result_title'}).a.text.replace('\n', '') + '\\\"' + ' ' + '\\\"' + i.find('div', {'class' : 'result_title'}).a['href'].split('&')[0].replace('search/r?entry=/', '') + '\\\"') for i in BeautifulSoup(requests.get(url).text).findAll('div', {'class': 'result_listing'})]"))"
    fi
}
function _asdfgh {
	google-chrome-stable "$2" 2>/dev/null &
}
function _search_hist_management {
    local historyFiles='/home/ellie/.config/,search'
    [ -f "$historyFiles/$1" ] || touch "$historyFiles/$1" ]
    if (( $# == 1 )); then
	    tr '\n' $'\n' < "$historyFiles/$1" | tac | paste -s -d '\n'
    elif (( $# == 2 )); then
	    echo "$2" >> $historyFiles/$1
    fi
}
if [[ $ZSH_EVAL_CONTEXT == 'toplevel' ]]; then
  elliesearch
fi
