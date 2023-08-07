#!/usr/bin/env bash

# Installs the latest Go release into $TARGETDIR (default: ~/.local)
# without requiring root access. Assumes the following suggested
# environment variables (which need to be set or changed in this script
# or after install completes):
#
#     PATH="~/.local/bin:~/.local/bin/go/bin:$PATH"
#     GOOS=linux
#     GOARCH=amd64
#     GOPATH="~/.local/go"
#     GOBIN="~/.local/go/bin"
#
# Note that the downloaded tar file is not removed and can be found in
# either $DOWNLOADS or /tmp.

true "${TARGETDIR:="$HOME/.local"}"

# change this to your target (detecting not always reliable)
declare GOOS=linux
declare GOARCH=amd64

lookup_file() {
	curl -sSL "https://go.dev/dl/?mode=json" |
		jq -r '.[0].files[]
       | select(.os == "'"$GOOS"'")
       | select(.arch == "'"$GOARCH"'")
       | .filename'
}

fetch() {
	local filename
	filename="$(lookup_file)"
	[[ -z "$filename" ]] && echo "unable to fetch filename" 1>&2 && return 1
	local path="/tmp/$filename"
	[[ -n "$DOWNLOADS" ]] && [[ -d "$DOWNLOADS" ]] && path="$DOWNLOADS/$filename"
	curl -L "https://go.dev/dl/$filename" -o "$path"
	echo "$path"
}

install_latest_go() {
	local dir="$1" path
	[[ -z "$dir" ]] && dir="$TARGETDIR"
	[[ -z "$dir" ]] && dir="$HOME/.local"
	mkdir -p "$dir" 2>/dev/null
	path="$(fetch)"
	[[ -z "$path" ]] && echo "unable to fetch go tarball" 1>&2 && return 1
	rm -rf "$dir/go" && tar -C "$dir" -xzf "$path" # rm is required by instructions
	echo "Add $dir/go/bin to your path and optionally set GOBIN=~/.local/bin" 1>&2
}

sudo pacman -Syu

sudo pacman -Ss exa jq fzf github-cli tmux gcc build-essential \
	procps curl file git nodejs neofetch bat lynx nmap pandoc jq pcregrep lynx \
       	make uidmap ruby python-is-python3 libcurses-perl tig zoxide figlet cmatrix \
	build-essential libncurses5-dev libncursesw5-dev autoconf entr shellcheck

echo "Installing Gum to make this script glamorous..."
sudo pacman -S gum

function info() {
  gum style "$*"
}

function title() {
  gum style --foreground=4 "=> $1"
}

function ask() {
  gum style --foreground=6 --bold -- "- $*"
}

function frame() {
  gum style --border=rounded --padding="0 1" --foreground=4 --margin=1 --border-foreground=4 "$@"
}

function link() {
  src="$1"
  dest="$2"
  if test -e "$dest"; then
    TIME=$(date +%s)
    BACKUP="$dest".backup."$TIME"
    mv "$dest" "$BACKUP" && info "moved $dest to $BACKUP" || info "failed to backup $dest to $BACKUP"
  fi

  ln -sf "$src" "$dest"
  info "Linked $src to $dest"
}

function setup_git() {
  user_name=""
  user_email=""
  if test -z "$(git config --global --get user.email)"; then
      ask 'What is your github author name?'
      user_name=$(gum input --placeholder="username")
      ask 'What is your github author email?'
      user_email=$(gum input --placeholder="email")

      test -n "$user_name"
        or echo "please inform the git author name"
      test -n "$user_email"
        or abort "please inform the git author email"
  fi

  git config --global user.name "$user_name" && git config --global user.email "$user_email"
}

frame "Starting setup..."

ask "At which dir do you want to store you code repos?"
CODE=$(gum input --value="$HOME/dev")

title "Linking..."
DOTFILES_PATH=$(pwd -P)
link "$DOTFILES_PATH/.config" "$HOME/.config"
link "$DOTFILES_PATH/home/.zshenv" "$HOME/.zshenv"
link "$DOTFILES_PATH/scripts" "$CODE/scripts"

title "Install latest Tmux Plugin Manager"
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

title "Install latest NeoVim"
sudo pacman -S neovim

title "Install NvChad"
mv ~/.config/nvim ~/.config/nvim2
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
cp -a ~/.config/nvim2/. ~/.config/nvim
rm -rf ~/.config/nvim2

title "Install Tui-Feed"
curl --proto '=https' --tlsv1.2 -sSLf "https://git.io/J1O0Z" | sh

title "Install Glow"
sudo pacman -S glow

title "Install Fish & set as default shell"
sudo pacman -S fish
chsh -s /usr/bin/fish

title "Install starship.rs"
curl -sS https://starship.rs/install.sh | sh

title "Install Golang"
install_latest_go

DONE_MSG=$(gum style --bold=true --foreground=4 "Done.")
LOGOUT_MSG=$(gum style --foreground=4  "Please login and logout from your mac.")
frame "$(gum join --vertical --align="center" "$DONE_MSG" "$LOGOUT_MSG")"

ask "Next steps:"
gum format -- "* Change any environment variables you need in \`$DOTFILES/.config/zsh/env.zsh\` to match your setup" \
  "* Edit any aliases in \`$DOTFILES/.config/zsh/aliases.zsh\` to match your config." \
  "* Run \`vim\` - and run :PlugInstall" \
  "* Install TuiFeed for a nice terminal based RSS feed [tuifeed](https://github.com/veeso/tuifeed#installation-)"
