
favourites(){
    echo -n "unixporn\nhackernews\ngithub\nreddit\n> "
    read t
    case $t in
        1)
            surf 'reddit.com/r/unixporn'
            ;;
        2)
            surf 'news.ycombinator.com'
            ;;
        3)
            surf 'github.com'
            ;;
        4)
            surf 'reddit.com'
            ;;
        *)
            search "$t"
            ;;
    esac

}
