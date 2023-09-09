# .bash_profile
# updated September 9, 2023

# paths
export PATH=$PATH:$GOPATH/bin
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export PATH=/opt/homebrew/bin:$PATH
export PATH="/Users/user/.npm:$PATH"
export GOPATH=/Users/user/go
export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"
export PYENV_ROOT="$HOME/.pyenv"

# prompt
COLOR_FOREGROUND="\033[0;0m"
COLOR_CYAN="\033[0;36m"
COLOR_RED="\033[0;31m"
function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"
  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch) "
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit) "
  fi
}
function git_status() {
  if [[ -z $(git status --porcelain 2> /dev/null) ]]; then
    echo -e "$COLOR_CYAN"
  else
    echo -e "$COLOR_RED"
  fi
}
export PS1="\[$COLOR_CYAN\]\W \[\$(git_status)\]\$(git_branch)\[$COLOR_CYAN\]$ \[$COLOR_FOREGROUND\]"

# default editor
export EDITOR=vim

alias c="clear"
alias cd..="cd ../"
alias ..="cd ../"
alias ...="cd ../../"
alias cp="cp -iv"
alias f="open -a Finder ./"
alias hc="history -c"
alias ll="ls -lahG"
alias mk="mkdir -v"
alias mv="mv -iv"
alias rm="rm -iv"
alias t="touch"
alias v="vim"
function ts() {
  touch "$1"
  sublime "$1"
}
function tv() {
  touch "$1"
  vim "$1"
}
function cdf() {
  currFolderPath=$( /usr/bin/osascript <<EOT
    tell application "Finder"
      try
    set currFolder to (folder of the front window as alias)
      on error
    set currFolder to (path to desktop folder as alias)
      end try
      POSIX path of currFolder
    end tell
EOT
  )
  cd "$currFolderPath"
}
function mc() {
  mkdir "$1"
  cd "$1"
}
function pwdc() {
  pwd | pbcopy
  pwd
}

# dotfiles
alias bp="vim ~/.bash_profile"
alias rbp="source ~/.bash_profile"
alias rtc="tmux source ~/.tmux.conf"
alias vrc="vim ~/.vimrc"
alias vtc="vim ~/.tmux.conf"
function udf() {
    cp ~/.bash_profile ~/Development/dotfiles
    cp ~/.tmux.conf ~/Development/dotfiles
    cp ~/.vimrc ~/Development/dotfiles
    cp ~/.vim/coc-settings.json ~/Development/dotfiles
    find ~/Development/dotfiles -type f -exec sed -i '' 's/user/user/g' {} \;
    git -C ~/Development/dotfiles add -A
    git -C ~/Development/dotfiles commit -m 'update'
    git -C ~/Development/dotfiles push origin main
}

# navigation
alias desk="cd ~/Desktop"
alias dev="cd ~/Development/"
alias doc="cd ~/Documents"
alias down="cd ~/Downloads"

# get all tasks
alias tasks='git grep -EI "TODO|FIXME"'

# git
alias ga="git add"
alias gaa="git add -A"
alias gb="git branch"
alias gbco="git checkout -b"
alias gcm="git commit -m"
alias gcsm="git commit -S -s -m"
alias gcl="git clone"
alias gco="git checkout"
alias gd="git diff"
alias gi="git init"
alias gl="git log"
alias gll="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
alias glll="gll --all"
alias gmc="git commit -m"
alias gpo="git push origin"
alias gpod="git push origin development"
alias gpom="git push origin main"
alias gpos="git push origin staging"
alias gs="git status -s"
alias gss="git status"
alias get="git"
alias got="git"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# go
alias grm="go run main.go"
alias gf="gofmt -s -w ."

# gpg agent
export GPG_TTY=$(tty)

# node
alias nn="node"

# open ports
alias ports="lsof -PiTCP -sTCP:LISTEN"

# python
alias per="pipenv run"
alias perp="pipenv run python"
alias perv="pipenv run vim"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

# rust
. "$HOME/.cargo/env"

# sublime
alias s="subl"
alias s.="subl ."

# tmux
alias tt="tmux new-session -n 'main'"
alias tta="tmux attach -t"
alias ttd="tmux detach"
alias tte="exit"
alias ttk="tmux kill-server"
alias ttl="tmux ls"
alias ttn="tmux new -s "

# silence zsh warning on a Mac
export BASH_SILENCE_DEPRECATION_WARNING=1
