export PATH=~/bin:$PATH

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="[\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\]]"

case `id -u` in
  0) PS1="${PS1}# ";;
  *) PS1="${PS1}$ ";;
esac

alias ll="ls -lahG"

export PATH="/usr/local/bin:$PATH"
alias vim="nvim"
alias top="htop"

export GOPATH="$HOME/projects"
export PATH="$HOME/.rbenv/bin:$GOPATH/bin:$PATH"
eval "$(rbenv init -)"

forest_fire() {
  echo "This deletes all of the following branches:" && \
  git branch --list $1\*
  confirm && git branch --list $1\* | xargs git branch -D
}

confirm() {
  read -r -p "${1:-Are you sure? [y/N]} " response
  case $response in
    [yY][eE][sS]|[yY])
      true
      ;;
    *)
      false
      ;;
  esac
}

LS_COLORS=$LS_COLORS:'di=40;34:' ; export LS_COLORS
export EDITOR=vim
export ANDROID_HOME=/Users/tb/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
