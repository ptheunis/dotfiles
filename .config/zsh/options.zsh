
# ⚠️  CONFIGURATION ⚠️
#
# https://zsh.sourceforge.io/Doc/Release/Options.html
#
# If you want to share history across terminal instances:
#   setopt SHARE_HISTORY
# But be warned this can be annoying when you want to ⬆️ the history and find your recent command is no longer the most recent.
#
setopt AUTO_CD
setopt CDABLE_VARS
setopt CD_SILENT
setopt CHASE_DOTS
setopt CHASE_LINKS
setopt ALWAYS_LAST_PROMPT
setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt AUTO_MENU
setopt AUTO_NAME_DIRS
setopt AUTO_PARAM_KEYS
setopt AUTO_PARAM_SLASH
setopt AUTO_REMOVE_SLASH
setopt COMPLETE_IN_WORD
setopt GLOB_COMPLETE
setopt HASH_LIST_ALL
setopt LIST_AMBIGUOUS
setopt LIST_PACKED
setopt LIST_TYPES
setopt MENU_COMPLETE
setopt EXTENDED_GLOB
setopt REMATCH_PCRE
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FCNTL_LOCK
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt ALIASES
setopt VI
setopt CORRECT
setopt CORRECT_ALL
unsetopt BEEP
unsetopt CASE_GLOB
unsetopt CASE_MATCH

# http://zsh.sourceforge.net/Doc/Release/Options.html#Expansion-and-Globbing
# By default, if a command line contains a globbing expression which doesn't
# match anything, Zsh will print the error message you're seeing, and not run
# the command at all. You can disable this using the following...
setopt +o nomatch

# increase number of file descriptors from default of 254
ulimit -n 10240
