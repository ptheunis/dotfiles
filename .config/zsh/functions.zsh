
# ---------------------- local utility functions ---------------------
_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }

# to ensure there are no duplicates in the $PATH
# we call dedupe at the end of each sourced shell script.
function dedupe {
  export PATH=$(echo -n $PATH | awk -v RS=: '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}')
}

# create directory structure and cd into it
#
function mkcdir() {
  mkdir -p -- "$1" && cd -P -- "$1"
}

# pretty print $PATH
#
function ppath() {
  echo "${PATH//:/$'\n'}"
}

# random number generator
# selects from the given number (default 100)
#
function rand() {
  local limit=${1:-100}
  seq $limit | gshuf -n 1
}

# tabs are indicated by ^I and line endings by $
# useful for validating things like a Makefile
#
function hiddenchars() {
  local filename=$1
  cat -e -t -v $filename
}

# delete tag from both local and remote repositories
#
function git_tag_delete() {
  git tag -d "v$1"
  git push --delete origin "v$1"
}

# cut a new release for a git project
#
function git_tag_release() {
  tag="v$1"
  git tag -s $tag -m "$tag" && git push origin $tag
  # git tag $tag -m "$tag" && git push origin $tag
}

# display contents of archive file
#
function list_contents() {
  if echo $1 | grep -Ei '.tar.gz$' &> /dev/null; then
    tar -ztvf $1
    return
  fi

  if echo $1 | grep -Ei '.zip$' &> /dev/null; then
    unzip -l $1
    return
  fi

  echo unsupported file extension
}

# clean out docker
#
function docker_clean() {
  dockerrmc
  dockerrmi
  dockerprune
}
