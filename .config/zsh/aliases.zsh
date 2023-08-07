
unalias -a

# scary
alias cat="batcat"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -riv"
alias mkdir='mkdir -vp'
alias l='$(!!) | less'

# brew
function update_choose() {
  cmds=("brew update && brew upgrade" "brew upgrade --cask --greedy" "npm update -g --fetch-timeout 3000" "yarn global upgrade" "gh extensions upgrade --all" "gup update" "rustup update")
  chose=$(gum choose --no-limit $cmds)
  for cmd in $chose
  do
    eval "$cmd"
  done
}
alias update='update_choose'

alias ip='ip -c'
alias '?'=duck
alias "??"=gpt
alias '???'=google
alias dot='cd $DOTFILES'
alias scripts='cd $SCRIPTS'
alias snippets='cd $SNIPPETS'
alias ls='ls -h --color=auto'
alias free='free -h'
alias tree='tree -a'
alias df='df -h'
alias chmox='chmod +x'
alias diff='diff --color'
alias temp='cd $(mktemp -d)'
alias view='vi -R' # which is usually linked to vim
alias clear='printf "\e[H\e[2J"'
alias c='printf "\e[H\e[2J"'
alias more="less"
alias sl=ls

if command -v exa &> /dev/null; then
	alias ll='exa -l --icons'
	alias lt='exa -l --icons --tree --level=2'
else
	alias ll='ls -l'
fi

alias ls="exa --group-directories-first --icons -a"
alias lcat="bat --paging=always"

_have vim && alias vi=vim

read -r -d '' commit_types <<- EOF
https://www.conventionalcommits.org/

build:    Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
ci:       Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
docs:     Documentation only changes
feat:     A new feature
fix:      A bug fix
perf:     A code change that improves performance
refactor: A code change that neither fixes a bug nor adds a feature
style:    Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
test:     Adding missing tests or correcting existing tests
EOF
alias commit='echo "$commit_types"'

alias dockerprune='docker system prune --all'
alias dockerrmi='docker rmi $(docker images -a -q)'
alias dockerrmc='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
alias fd='fd --hidden'
alias ff='fzf --multi'

# git alias' with git autocomplete support
#
# __git_complete is lazy loaded by the bash shell, meaning calling it in bash
# configuration files like .bash_profile and .bashrc won't work because it
# won't be loaded yet.
#
# to solve this problem I source the internal code at the top of this file
# (look for: source ~/.git-completion.bash)
#
# NOTE: for information on the new `git switch` and `git restore` commands...
# https://www.banterly.net/2021/07/31/new-in-git-switch-and-restore/
#
alias g="git"
alias ga="git add"
alias gai="forgit::add"
alias gb="git branch-verbose"
alias gc="git checkout"
alias gcp="forgit::cherry::pick"
alias gd="git diff"
alias gdw="git diff-word"
alias gdi="forgit::diff"
alias gup="git push"
alias gdown="git pull"
alias gr="git rebase"
alias gri="forgit::rebase"
alias grs="git restore"
alias gsh="git stash"
alias gshs="forgit::stash::show"
alias gsw="git switch"

# git abstraction alias'
# some of these (e.g. pushit, wip etc) are custom alias defined in ~/.gitconfig
#
# NOTE: some of these abstractions (e.g. gbd, gpr) need autocomplete support still.
#
alias gap="git add --patch"
alias gbd="git branch -D"
alias gcm="git commit"
alias gca="git commit --amend"
alias gco="git checkout origin/main --" # followed by path to file to checkout
alias gcoi="forgit::checkout::file"
alias gcv="git commit -v"
alias gf="git pushit"
alias gl="git log-graphstat"
alias gli="forgit::log"
alias glm="git log-me"
alias gls="git log-short"
alias golatest="curl -L https://github.com/golang/go/tags 2>&1 | ag '/golang/go/releases/tag/go[\w.]+' -o | cut -d '/' -f 6 | awk NR==1 | ag '\d.+' -o"
alias golatestall="curl -s 'https://go.dev/dl/?mode=json' | jq -c '.[]' | jq -c '.files[] | select(.os == \"darwin\" or .os == \"linux\" or .os == \"freebsd\") | select(.arch == \"386\" or .arch == \"amd64\" or .arch == \"armv6l\" or .arch == \"arm64\") | select(.kind == \"archive\")'"
alias gpr="git pull --rebase origin" # make sure to specify the branch name!
alias gst="git st"
alias gstm="git stm"
alias gwip="git wip"


alias ips="arp -a" # some IPs (like my NAS DS220) don't show up until I able to ping it as that starts up the box.
alias json="python -m json.tool"

alias r="source ~/.zshrc"
alias sizeit="du -ahc" # can also add on a path at the end `sizeit ~/some/path`
alias top='htop'
alias uid="uuidgen"
alias weather="curl wttr.in"

read -r -d '' git_icons <<- EOF
# starship prompt...

conflicted "="	merge conflicts.
ahead      "⇡"	ahead
behind     "⇣"	behind
diverged   "⇕"	diverged
untracked  "?"	untracked
stashed    "$"	stashed
modified   "!"	modified
staged     "+"	staged
renamed    "»"	renamed
deleted    "✘"  deleted
EOF
alias wat='echo "$git_icons"'
alias wut='echo "$git_icons"'

