### init.lua, formerly dotfiles

```sh
git clone git@github.com:tbash/init.lua.git ~/.config/nvim --depth 1
```

#### I'll find a home for these files later

## .Brewfile

```sh
cask_args appdir: "/Applications"

tap "homebrew/cask"

brew "asdf"
brew "awscli"
brew "gpg"
brew "htop"
brew "luajit"
brew "neovim"
brew "ripgrep"
brew "tmux"
brew "tree-sitter"

cask "discord"
cask "google-chrome"
```

## .zshrc

```sh
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
```

## .tmux.conf

```
# https://github.com/seebi/tmux-colors-solarized/blob/master/tmuxcolors-256.conf
set-option -g status-style bg=colour235,fg=colour136,default

# set window split
bind-key v split-window -h
bind-key b split-window

# default window title colors
set-window-option -g window-status-style fg=colour244,bg=default,dim

# active window title colors
set-window-option -g window-status-current-style fg=colour166,bg=default,bright

# pane border
set-option -g pane-border-style fg=colour235
set-option -g pane-active-border-style fg=colour240

# message text
set-option -g message-style bg=colour235,fg=colour166

# pane number display
set-option -g display-panes-active-colour colour33 #blue
set-option -g display-panes-colour colour166 #orange
# clock
set-window-option -g clock-mode-colour green #green


set -g status-interval 1
set -g status-justify centre # center align window list
set -g status-left-length 20
set -g status-right-length 140
set -g status-left '#[fg=green]#H #[fg=black]• #[fg=green,bright]#(uname -r | cut -c 1-6)#[default]'
set -g status-right '%a %h-%d %H:%M '
# set -g status-right '#[fg=green,bg=default,bright]#(tmux-mem-cpu-load) #[fg=red,dim,bg=default]#(uptime | cut -f 4-5 -d " " | cut -f 1 -d ",") #[fg=white,bg=default]%a%l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d'

# C-b is not acceptable -- Vim uses it
set-option -g prefix C-a
bind-key C-a last-window

# Start numbering at 1
set -g base-index 1

# Allows for faster key repetition
set -s escape-time 0

# Rather than constraining window size to the maximum size of any client
# connected to the *session*, constrain window size to the maximum size of any
# client connected to *that window*. Much more reasonable.
setw -g aggressive-resize on

# Allows us to use C-a a <command> to send commands to a TMUX session inside
# another TMUX session
bind-key a send-prefix

# Activity monitoring
setw -g monitor-activity on
set -g visual-activity on

# Vi copypaste mode
set-window-option -g mode-keys vi

# hjkl pane traversal
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind m split-window -v\; set-window-option main-pane-height 45\; split-window -h\; select-layout main-horizontal

bind-key C command-prompt -p "Name of new window: " "new-window -n '%%'"

# reload config
bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."

# auto window rename
set-window-option -g automatic-rename

# color
set -g default-terminal "screen-256color"

# from powerline
run-shell "tmux set-environment -g TMUX_VERSION_MAJOR $(tmux -V | cut -d' ' -f2 | cut -d'.' -f1 | sed 's/[^0-9]*//g')"
run-shell "tmux set-environment -g TMUX_VERSION_MINOR $(tmux -V | cut -d' ' -f2 | cut -d'.' -f2 | sed 's/[^0-9]*//g')"

# status bar
if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -lt 2\) -o #{$TMUX_VERSION_MAJOR} -le 1' 'set-option -g status-utf8 on'

# rm mouse mode fail
if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -ge 1\)' 'set -g mouse off'
if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -lt 1\) -o #{$TMUX_VERSION_MAJOR} -le 1' 'set -g mode-mouse off'

# fix pane_current_path on new window and splits
if-shell "test '#{$TMUX_VERSION_MAJOR} -gt 1 -o \( #{$TMUX_VERSION_MAJOR} -eq 1 -a #{$TMUX_VERSION_MINOR} -ge 8 \)'" 'unbind c; bind c new-window -c "#{pane_current_path}"'
if-shell "test '#{$TMUX_VERSION_MAJOR} -gt 1 -o \( #{$TMUX_VERSION_MAJOR} -eq 1 -a #{$TMUX_VERSION_MINOR} -ge 8 \)'" "unbind '\"'; bind '\"' split-window -v -c '#{pane_current_path}'"
if-shell "test '#{$TMUX_VERSION_MAJOR} -gt 1 -o \( #{$TMUX_VERSION_MAJOR} -eq 1 -a #{$TMUX_VERSION_MINOR} -ge 8 \)'" 'unbind v; bind v split-window -h -c "#{pane_current_path}"'
```

## .gitconfig

```
[alias]
  ls = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate
  ll = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat
  lds = log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short
  ld = log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative
  graph = log --pretty=oneline --abbrev-commit --graph --decorate
  la = "!git config -l | grep alias | cut -c 7-"
  cp = cherry-pick
  s = status
  st = status -s
  cl = clone
  ci = commit
  co = checkout
  br = branch
  diff = diff --word-diff
  dc = diff --cached
  oops = reset HEAD^1
[color]
  ui = true
[color "diff"]
  meta = yellow bold
  frag = magenta bold
  old = red reverse
  new = green reverse
  whitespace = white reverse
[color "branch"]
  current = green reverse
  local = yellow
  remote = magenta
[user]
  name = Brandon Ashley
  email = tb@tba.sh
  signingkey = /Users/tbash/.ssh/id_ed25519.pub
[github]
  user = tbash
[gitlab]
  user = tbash
[credential]
  helper = osxkeychain
[core]
  autocrlf = input
  editor = vim
  excludesfile = /Users/tbash/.gitignore_global
[merge]
  tool = opendiff
[difftool "sourcetree"]
  cmd = opendiff \"$LOCAL\" \"$REMOTE\"
  path =
[rerere]
  enabled = true
[pull]
  rebase = true
[default]
  default = simple
[push]
  default = current
[gpg]
  format = ssh
[commit]
  gpgsign = true
```

## .gitignore_global

```
# Compiled source #
###################
*.com
*.class
*.dll
*.exe
*.o
*.so

# Packages #
############
# it's better to unpack these files and commit the raw source
# git has its own built in compression methods
*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip

# Logs and databases #
######################
*.log
*.sql
*.sqlite

# OS generated files #
######################
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Vim generated files #
######################
*.swp
*.swo
```

## Catppuccin.terminal

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>ANSIBlackColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC4yMDg1NjM2NTU2IDAuMjEyODUzMDQ0
	MyAwLjI4MTQ5OTU5NDQAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>ANSIBlueColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC41MzcyNDk5ODI0IDAuNzA1ODc5OTg2
	MyAwLjk4MDM5MDAxMjMAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>ANSIBrightBlackColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC4yNzQ1OTA2MTE1IDAuMjgyNTQzMTUy
	NiAwLjM2MzU3NjM4MjQAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>ANSIBrightBlueColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC41MzcyNDk5ODI0IDAuNzA1ODc5OTg2
	MyAwLjk4MDM5MDAxMjMAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>ANSIBrightCyanColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC41MTk4NDQ2NTEyIDAuODY2NzU2NDM5
	MiAwLjc5NzEzODA5NDkAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>ANSIBrightGreenColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAkMC41OTQzMDQ4IDAuODc3MjQ5NTM4OSAw
	LjU2NDMzMzY3NzMAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xvcqIW
	GFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+paeprrnCys0AAAAAAAABAQAAAAAAAAAZ
	AAAAAAAAAAAAAAAAAAAA1g==
	</data>
	<key>ANSIBrightMagentaColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC45NDQ5NzE3NDAyIDAuNjk3NjkyMTU1
	OCAwLjg4MjcyMzk4NzEAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>ANSIBrightRedColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC45MzE0MDgxNjY5IDAuNDUzNDQ5OTA0
	OSAwLjU5NDUzNDYzNTUAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>ANSIBrightWhiteColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC41ODU4MDEyNDM4IDAuNjExOTY0NzAy
	NiAwLjczNjc0NjM3MDgAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>ANSIBrightYellowColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAmMC45NjgxMDU0OTUgMC44NjM2ODIyNzAx
	IDAuNjI1NzY2OTkyNgAQAYAC0hQVFhdaJGNsYXNzbmFtZVgkY2xhc3Nlc1dOU0NvbG9y
	ohYYWE5TT2JqZWN0CBEaJCkyN0lMUVNXXWRqd36nqauwu8TMzwAAAAAAAAEBAAAAAAAA
	ABkAAAAAAAAAAAAAAAAAAADY
	</data>
	<key>ANSICyanColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC41MTk4NDQ2NTEyIDAuODY2NzU2NDM5
	MiAwLjc5NzEzODA5NDkAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>ANSIGreenColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAkMC41OTQzMDQ4IDAuODc3MjQ5NTM4OSAw
	LjU2NDMzMzY3NzMAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xvcqIW
	GFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+paeprrnCys0AAAAAAAABAQAAAAAAAAAZ
	AAAAAAAAAAAAAAAAAAAA1g==
	</data>
	<key>ANSIMagentaColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC45NDQ5NzE3NDAyIDAuNjk3NjkyMTU1
	OCAwLjg4MjcyMzk4NzEAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>ANSIRedColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC45MzE0MDgxNjY5IDAuNDUzNDQ5OTA0
	OSAwLjU5NDUzNDYzNTUAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>ANSIWhiteColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC42NzQxOTIxOTAyIDAuNzA1NjUzNDg4
	NiAwLjgzOTQ0MDk0MTgAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>ANSIYellowColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAmMC45NjgxMDU0OTUgMC44NjM2ODIyNzAx
	IDAuNjI1NzY2OTkyNgAQAYAC0hQVFhdaJGNsYXNzbmFtZVgkY2xhc3Nlc1dOU0NvbG9y
	ohYYWE5TT2JqZWN0CBEaJCkyN0lMUVNXXWRqd36nqauwu8TMzwAAAAAAAAEBAAAAAAAA
	ABkAAAAAAAAAAAAAAAAAAADY
	</data>
	<key>BackgroundBlur</key>
	<real>0.0</real>
	<key>BackgroundColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAoMC4wODkzOTQ1NTQ1IDAuMDg3NjE3NTYx
	MjIgMC4xMzUxOTc5ODIyABABgALSFBUWF1okY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29s
	b3KiFhhYTlNPYmplY3QIERokKTI3SUxRU1ddZGp3fqmrrbK9xs7RAAAAAAAAAQEAAAAA
	AAAAGQAAAAAAAAAAAAAAAAAAANo=
	</data>
	<key>CursorColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC45NDgzMzg1MDg2IDAuODQ3OTA1NTc2
	MiAwLjgzMDY2MDQwMjgAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>DisableANSIColor</key>
	<false/>
	<key>Font</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGkCwwVFlUkbnVsbNQNDg8QERIT
	FFZOU1NpemVYTlNmRmxhZ3NWTlNOYW1lViRjbGFzcyNAMgAAAAAAABAQgAKAA15TYXVj
	ZUNvZGVQcm9ORtIXGBkaWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNGb250ohkbWE5TT2Jq
	ZWN0CBEaJCkyN0lMUVNYXmdud36FjpCSlKOos7zDxgAAAAAAAAEBAAAAAAAAABwAAAAA
	AAAAAAAAAAAAAADP
	</data>
	<key>FontAntialias</key>
	<true/>
	<key>FontHeightSpacing</key>
	<real>0.94999999999999996</real>
	<key>FontWidthSpacing</key>
	<real>1.1000000000000001</real>
	<key>ProfileCurrentVersion</key>
	<real>2.0699999999999998</real>
	<key>SelectionColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC4yNzQ1OTA2MTE1IDAuMjgyNTQzMTUy
	NiAwLjM2MzU3NjM4MjQAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>ShowActiveProcessArgumentsInTitle</key>
	<false/>
	<key>ShowActiveProcessInTitle</key>
	<true/>
	<key>ShowDimensionsInTitle</key>
	<false/>
	<key>TerminalType</key>
	<string>xterm-256colour</string>
	<key>TextBoldColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC43NjA5NDE2MjQ2IDAuNzk3Njk1ODc1
	MiAwLjk0NTM1NjEzMDYAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>TextColor</key>
	<data>
	YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMS
	AAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGjCwwTVSRudWxs0w0ODxARElVO
	U1JHQlxOU0NvbG9yU3BhY2VWJGNsYXNzTxAnMC43NjA5NDE2MjQ2IDAuNzk3Njk1ODc1
	MiAwLjk0NTM1NjEzMDYAEAGAAtIUFRYXWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xv
	cqIWGFhOU09iamVjdAgRGiQpMjdJTFFTV11kand+qKqssbzFzdAAAAAAAAABAQAAAAAA
	AAAZAAAAAAAAAAAAAAAAAAAA2Q==
	</data>
	<key>UseBoldFonts</key>
	<true/>
	<key>UseBrightBold</key>
	<false/>
	<key>name</key>
	<string>Catppuccin</string>
	<key>type</key>
	<string>Window Settings</string>
</dict>
</plist>
```
