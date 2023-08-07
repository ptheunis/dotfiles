set -U fish_greeting # disable fish greeting

set -gx GUM_FILTER_INDICATOR "→"
set -gx GUM_FILTER_PROMPT " "

# Alacritty Fish bindings
if [ -f $HOME/.config/fish/alacritty.fish ]
  source $HOME/.config/fish/alacritty.fish
end

if [ -f $HOME/.config/fish/exports.fish ]
  source $HOME/.config/fish/exports.fish
end

if [ -f $HOME/.config/fish/aliases.fish ]
  source $HOME/.config/fish/aliases.fish
end


if [ -f $HOME/.config/fish/functions.fish ]
  source $HOME/.config/fish/functions.fish
end

# for things not checked into git..
if [ -f $HOME/.extra.fish ]
	source $HOME/.extra.fish
end

if ! command -v go &> /dev/null
  install-go
  install-go-dev
end

starship init fish | source
