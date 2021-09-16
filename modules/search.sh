#!/bin/zsh
elliesearch(){
    local site
    local article_text_flag
    site="https://google.com/search?q=%s"
    while [[ "$1" == -* ]]; do
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
                pdfflag="is now set"
                site="https://plato.stanford.edu/search/searcher.py?query=%s~"
                ;;
            "-lg"|"--libgen")
                site="https://libgen.is/search.php?req=%s&open=0&res=100&view=detailed"
                ;;
            "-al"|"--anarchist-library")
                site="http://theanarchistlibrary.org/search?query=%s"
                ;;
            "-h"|"--help")
                _ellieSearchHelpText_
                exit 2
                ;;
            "--textoutput")
                article_text_flag="true now I guess"
                local textoutputFormat
                textoutputFormat="markdown"
                case $2 in
                   "asciidoc")
	                    textoutputFormat="asciidoc"
                            shift
	                    ;;
                    "beamer")
                            textoutputFormat="beamer"
                            shift
                            ;;
                    "bibtex")
                            textoutputFormat="bibtex"
                            shift
                            ;;
                    "biblatex")
                            textoutputFormat="biblatex"
                            shift
                            ;;
                    "commonmark")
                            textoutputFormat="commonmark"
                            shift
                             ;;
                    "commonmark_x")
                            textoutputFormat="commonmark_x"
                            shift
                            ;;
                    "context")
                            textoutputFormat="context"
                            shift
                            ;;
                    "csljson")
                            textoutputFormat="csljson"
                            shift
                            ;;
                    "docbook")
                            textoutputFormat="docbook"
                            shift
                            ;;
                    "docbook5")
                            textoutputFormat="docbook5"
                            shift
                            ;;
                    "docx")
                            textoutputFormat="docx"
                            shift
                            ;;
                    "dokuwiki")
                            textoutputFormat="dokuwiki"
                            shift
                            ;;
                    "epub")
                            textoutputFormat="epub"
                            shift
                            ;;
                    "epub2")
                            textoutputFormat="epub2"
                            shift
                            ;;
                    "fb2")
                            textoutputFormat="fb2"
                            shift
                            ;;
                    "gfm")
                            textoutputFormat="gfm"
                            shift
                            ;;
                    "haddock")
                            textoutputFormat="haddock"
                            shift
                            ;;
                    "html")
                            textoutputFormat="html"
                            shift
                            ;;
                    "html4")
                            textoutputFormat="html4"
                            shift
                            ;;
                    "icml")
                            textoutputFormat="icml"
                            shift
                            ;;
                    "ipynb")
                            textoutputFormat="ipynb"
                            shift
                            ;;
                    "jats_archiving")
                            textoutputFormat="jats_archiving"
                            shift
                            ;;
                    "jats_articleauthoring")
                            textoutputFormat="jats_articleauthoring"
                            shift
                            ;;
                    "jats_publishing")
                            textoutputFormat="jats_publishing"
                            shift
                            ;;
                    "jats")
                            textoutputFormat="jats"
                            shift
                            ;;
                    "jira")
                            textoutputFormat="jira"
                            shift
                            ;;
                    "json")
                            textoutputFormat="json"
                            shift
                            ;;
                    "latex")
                            textoutputFormat="latex"
                            shift
                            ;;
                    "man")
                            textoutputFormat="man"
                            shift
                            ;;
                    "markdown")
                            textoutputFormat="markdown"
                            shift
                            ;;
                    "markdown_mmd")
                            textoutputFormat="markdown_mmd"
                            shift
                            ;;
                    "markdown_phpextra")
                            textoutputFormat="markdown_phpextra"
                            shift
                            ;;
                    "markdown_strict")
                            textoutputFormat="markdown_strict"
                            shift
                            ;;
                    "mediawiki")
                            textoutputFormat="mediawiki"
                            shift
                            ;;
                    "ms")
                            textoutputFormat="ms"
                            shift
                            ;;
                    "muse")
                            textoutputFormat="muse"
                            shift
                            ;;
                    "native")
                            textoutputFormat="native"
                            shift
                            ;;
                    "odt")
                            textoutputFormat="odt"
                            shift
                            ;;
                    "opml")
                            textoutputFormat="opml"
                            shift
                            ;;
                    "opendocument")
                            textoutputFormat="opendocument"
                            shift
                            ;;
                    "org")
                            textoutputFormat="org"
                            shift
                            ;;
                    "pdf")
                            textoutputFormat="pdf"
                            shift
                            ;;
                    "plain")
                            textoutputFormat="plain"
                            shift
                            ;;
                    "pptx")
                            textoutputFormat="pptx"
                            shift
                            ;;
                    "rst")
                            textoutputFormat="rst"
                            shift
                            ;;
                    "rtf")
                            textoutputFormat="rtf"
                            shift
                            ;;
                    "texinfo")
                            textoutputFormat="texinfo"
                            shift
                            ;;
                    "textile")
                            textoutputFormat="textile"
                            shift
                            ;;
                    "slideous")
                            textoutputFormat="slideous"
                            shift
                            ;;
                    "slidy")
                            textoutputFormat="slidy"
                            shift
                            ;;
                    "dzslides")
                            textoutputFormat="dzslides"
                            shift
                            ;;
                    "revealjs")
                            textoutputFormat="revealjs"
                            shift
                            ;;
                    "s5")
                            textoutputFormat="s5"
                            shift
                            ;;
                    "tei")
                            textoutputFormat="tei"
                            shift
                            ;;
                    "xwiki")
                            textoutputFormat="xwiki"
                            shift
                            ;;
                    "zimwiki")
                            textoutputFormat="zimwiki" 
                            shift
                            ;;
                        *)
                            echo "Unrecognised format $2 defauting to $textoutputFormat"
                            ;;
                    esac
                    ;;
                    *)
                    echo "unrecognised "$1" defaulting to search $site"
                    ;;
            esac
            shift
        done 
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
    local url="$(printf "$site" "$(echo "$searchTerm" | tr ' ' '+')")"
    if [ -z $pdfflag ]; then
        _asdfgh dummyArg $url
    else
        eval "_asdfgh $(fzf --layout=reverse < <(echo "$url" | python3 -c "import requests; from bs4 import BeautifulSoup; url = input(); [print('\\\"' + i.find('div', {'class' : 'result_title'}).a.text.replace('\n', '') + '\\\"' + ' ' + '\\\"' + i.find('div', {'class' : 'result_title'}).a['href'].split('&')[0].replace('search/r?entry=/', '') + '\\\"') for i in BeautifulSoup(requests.get(url).text).findAll('div', {'class': 'result_listing'})]"))"
    fi
}
function _asdfgh {
    if [ -z $article_text_flag ]; then
        google-chrome-stable "$2" 2>/dev/null &
    else
        pandoc -f html -t $textoutputFormat "$2" || echo "text output for this failed"
    fi
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
function _ellieSearchHelpText_ {
    cat << EOM
elliesearch [opts] searchTerm

options:
    -y|--youbtube                            search youtube.com
    -g|--google                              search with google (default)
    -w|--wikipedia                           search wikipedia
    -p|--philosophy                          search stanford.plato
    -l|--libgen                              search libgen
    -al|--anarchist-library                  search the anarchist library
    --textoutput [format]                    toggle text output and specify format
    -h|--help                                print this message and exit
EOM
}

if [[ $ZSH_EVAL_CONTEXT == 'toplevel' ]]; then
  elliesearch "$@"
fi

