# scary
abbr --add rm "rm -i"
abbr --add mv "mv -i"
abbr --add cp "cp -riv"
abbr --add mkdir 'mkdir -vp'

# neovim
abbr --add vim "nvim"
abbr --add v "nvim"
abbr --add vi "nvim"

# configs
abbr --add ez "nvim $HOME/.config/fish/config.fish"
abbr --add sz "source $HOME/.config/fish/config.fish"
abbr --add ea "nvim $HOME/.config/fish/config.fish"
abbr --add ev "nvim $HOME/.config/nvim/"
abbr --add dot "nvim $HOME/dotfiles"
abbr --add cdot "cd $HOME/dotfiles"

abbr --add ".." "cd ../"
abbr --add "..." "cd ../../"
abbr --add "...." "cd ../../../"
abbr --add "....." "cd ../../../../"
abbr --add "......" "cd ../../../../../"
abbr --add "......." "cd ../../../../../../"
abbr --add lcat "bat --paging always"
abbr --add cat "bat"
abbr --add gcode "$DEV"
abbr --add gd "cd $HOME/Downloads"

# others
abbr --add "k" "kubectl"
abbr --add less 'less -r'
abbr --add c "clear"
abbr --add where 'which'

abbr --add ip 'ip -c'
abbr --add dot 'cd $DOTFILES'
abbr --add scripts 'cd $SCRIPTS'
abbr --add snippets 'cd $SNIPPETS'
abbr --add ls 'ls -h --color=auto'
abbr --add free 'free -h'
abbr --add tree 'tree -a'
abbr --add df 'df -h'
abbr --add chmox 'chmod +x'
abbr --add diff 'diff --color'
abbr --add temp 'cd $(mktemp -d)'
abbr --add view 'vi -R' # which is usually linked to vim
abbr --add clear 'printf "\e[H\e[2J"'
abbr --add c 'printf "\e[H\e[2J"'
abbr --add more "less"
abbr --add sl ls

abbr --add dockerprune 'docker system prune --all'
abbr --add dockerrmi 'docker rmi $(docker images -a -q)'
abbr --add dockerrmc 'docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
abbr --add fd 'fd --hidden'
abbr --add ff 'fzf --multi'

abbr --add ips "arp -a" # some IPs (like my NAS DS220) don't show up until I able to ping it as that starts up the box.
abbr --add json "python -m json.tool"

abbr --add r "source ~/.config/fish/config.fish"
abbr --add sizeit "du -ahc" # can also add on a path at the end `sizeit ~/some/path`
abbr --add top 'htop'
abbr --add uid "uuidgen"
abbr --add weather "curl wttr.in"
