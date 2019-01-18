export ZSH=/Users/brandonashley/.dotfiles/oh-my-zsh

ZSH_THEME="robbyrussell"
DEFAULT_USER="brandonashley"
plugins=(git tmux postgres stack docker)

export UPDATE_ZSH_DAYS=30
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

export EDITOR=vim

export PATH="/Users/brandonashley/.local/bin:$PATH"

alias git-pull-ls="ls | xargs -P10 -I{} git -C {} pull"
alias top="htop"
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
