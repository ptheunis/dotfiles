function killf
  if ps -ef | sed 1d | fzf -m | awk '{print $2}' > $TMPDIR/fzf.result
    kill -9 (cat $TMPDIR/fzf.result)
  end
end

function all_binaries_in_path --description "list all binaries available in \$PATH, even if theres conflicts"
  # based on https://unix.stackexchange.com/a/120790/110766 but tweaked to work on mac. and then made it faster.
  find -L $PATH -maxdepth 1 -perm +111 -type f
  #gfind -L $PATH -maxdepth 1 -executable -type f # shrug. probably can delete this.
end


function md --wraps mkdir -d "Create a directory and cd into it"
  command mkdir -p $argv
  if test $status = 0
    switch $argv[(count $argv)]
      case '-*'
      case '*'
        cd $argv[(count $argv)]
        return
    end
  end
end

function install-go
  printf "Checking latest Go version...\n";
  set LATEST_GO_VERSION "$(curl --silent https://go.dev/VERSION\?m=text)";
  set LATEST_GO_DOWNLOAD_URL "https://golang.org/dl/$LATEST_GO_VERSION.linux-amd64.tar.gz "

  printf "cd to home ($USER) directory \n"
  cd "/home/$USER"

  printf "Downloading $LATEST_GO_DOWNLOAD_URL\n\n";
  curl -OJ -L --progress-bar https://golang.org/dl/$LATEST_GO_VERSION.linux-amd64.tar.gz

  printf "Extracting file...\n"
  tar -xf $LATEST_GO_VERSION.linux-amd64.tar.gz

end

function install-go-dev
  go install github.com/rakyll/gotest@latest
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
  go install github.com/mgechev/revive@latest
  go install golang.org/x/tools/gopls@latest
  go install github.com/incu6us/goimports-reviser/v3@latest
  go install mvdan.cc/gofumpt@latest
  go install honnef.co/go/tools/cmd/staticcheck@2023.1
  go install golang.org/x/vuln/cmd/govulncheck@latest
  go install github.com/go-delve/delve/cmd/dlv@latest
  go install github.com/segmentio/golines@latest
end
