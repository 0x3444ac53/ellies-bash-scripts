
ittybittynote(){
    surf itty.bitty.site 2>>/dev/null &!
    apikey=a971c367792de14df515a0c408fb334a302bea89
    username="o_14v14ujs0o"
    echo -n 'link: ' 
    read linktonote;
    echo $linktonote
    for i in $(curl -s --request GET --url "https://api-ssl.bitly.com/v3/shorten?access_token=$apikey&login=$username&longUrl=$linktonote" | jq '.[]'); do 
        if [[ $i == *"http://bit.ly/"* ]]
        then fuck=${i:0:-2}
        fi
    done 
    echo ${fuck:1:$(echo $fuck | wc -c)} >> ~/Documents/ittybittynotes
    echo $linktonote >> ~/Documents/LONGittybittynotes
}
