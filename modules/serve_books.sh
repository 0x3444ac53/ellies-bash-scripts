#!/bin/zsh
function Serve {
    local rootdir
    [ -v 1 ] && rootdir=$1 || rootdir="$(pwd)"
    genIndex "$rootdir"
    echo "http://$(ip addr show wls3 | grep "inet\b" | cut -c 10- | cut -d "/" -f1):8080"
    surf "$(ip addr show wls3 | grep "inet\b" | cut -c 10- | cut -d "/" -f1):8080" > /dev/null 2>&1 &
    python3 -m http.server --directory "$rootdir" 8080
}
function genIndex {
    local theDirectory="$1"
    echo "Generating index for $theDirectory"
    echo '<!DOCTYPE html><html><head><title>'$theDirectory'</title><style>html{background-color:#f4f4f4;}a{color:#373737;text-decoration:none;}.file::before{content:"\1f5ba";}.folder::before{content:"\1f5c0";}.folder:hover:before{content:"\1f5c1";}ul{list-style:none;}</style></head><body><ul><h1>&#128449'$theDirectory'</h1><ul>' > "${theDirectory}/index.html"
    local name
    local class
    for i in $theDirectory/*; do
        name="$(basename $i)"
        class="file"
        if [[ -d "$i" ]]; then
            genIndex "$i"
            class="folder"
        fi
        echo "<li class="\"$class\""><a href="\"$name\"">$name</a></li>" >> $theDirectory/index.html
    done
    echo "</ul></ul></body></html>" >> $theDirectory/index.html
    echo "$theDirectory"
}
