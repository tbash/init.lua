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

alias vim="TERM=xterm-256color nvim"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export ECLIPSE=/Applications/Eclipse.app/Contents/Eclipse
alias eclim="$ECLIPSE/eclimd"

forest_fire() {
  echo "This deletes all of the following branches:" && \
  git branch --list "$1"
  confirm && git branch --list "$1" | xargs git branch -D
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
