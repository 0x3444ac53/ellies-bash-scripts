copyFile(){
python3 -c "print(''.join([line for line in open('$1')]), end='')" | xclip -selection clipboard
}
