export ZSH=/Users/brandonashley/.dotfiles/oh-my-zsh

ZSH_THEME="robbyrussell"
DEFAULT_USER="brandonashley"
plugins=(git tmux postgres)

export UPDATE_ZSH_DAYS=30
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

export GOPATH="$HOME/projects"
export EDITOR=nvim
export ANDROID_HOME=/Users/tb/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

alias git-pull-ls="ls | xargs -P10 -I{} git -C {} pull"
alias vim="nvim"
alias top="htop"
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

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
