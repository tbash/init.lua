export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
DEFAULT_USER="tbash"
plugins=(git docker)

export UPDATE_ZSH_DAYS=30
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim

export PATH="/usr/local/bin:$PATH"

alias git-pull-ls="ls | xargs -P10 -I{} git -C {} pull"
alias top="htop"
alias afk="pmset displaysleepnow"
alias vim="nvim"
alias vi="nvim"

. $(brew --prefix asdf)/libexec/asdf.sh
. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fpath=(~/.stripe $fpath)
autoload -Uz compinit && compinit -i
