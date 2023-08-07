# User Exports

set -x LANG en_US.UTF-8 # assuming apt install language-pack-en done
set -x TZ America/New_York
set -x HRULEWIDTH 73
set -x EDITOR nvim
set -x VISUAL nvim
set -x EDITOR_PREFIX nvim

# git specific configurations
#
set -x GIT_PS1_SHOWCOLORHINTS true
set -x GIT_PS1_SHOWDIRTYSTATE true     # * for unstaged changes (+ staged but uncommitted changes)
set -x GIT_PS1_SHOWSTASHSTATE true     # $ for stashed changes
set -x GIT_PS1_SHOWUNTRACKEDFILES true # % for untracked files
set -x GIT_PS1_SHOWUPSTREAM "auto"     # > for local commits on HEAD not pushed to upstream
                                       # < for commits on upstream not merged with HEAD
                                       # = HEAD points to same commit as upstream


