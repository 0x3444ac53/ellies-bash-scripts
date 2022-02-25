PROMPT='%(?..$(ellies_exit_code $?)) $(ellies_directory_shower_thingy) $(git_prompt_info)%{$reset_color%}'

ellies_directory_shower_thingy(){
    local script
    read -r -d '' script << EOM
dir = input()
if dir == '/home/ellie': print(""); exit(0)
dir = dir.split('/')[1:]
if len(dir) % 2 != 0: dir += ['', '']
multiline_dir = [(dir[i-1], dir[i]) for i in range(1, len(dir), 2)]
print(' /'+'/\\\n ↳  '.join(map(lambda x: '/'.join(x), 
    map(lambda y : filter(lambda x: not not x, y), multiline_dir))) + '/')
EOM
echo '\e[3m'"$(pwd | python3 <(echo $script))"'\e[0m'

}

ellies_exit_code(){
   local script
   read -r -d '' script << EOM
returnCode = int(input())
if returnCode == 127: print(''); exit()
if returnCode == 126: print('(╯°□°）╯︵ ┻━┻'); exit()
if returnCode ==   2: print('( ⊙_⊙)'); exit()
if returnCode == 130: print(''); exit()
if returnCode ==   1: print('✗'); exit()
print(f"?={returnCode}")
EOM
echo $1 | python3 <(echo $script)
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
