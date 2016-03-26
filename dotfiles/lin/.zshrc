# Path to your oh-my-zsh installation.
export ZSH=/home/swint/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(extract git sudo web-search z)

# User configuration

export PATH="/usr/local/MATLAB/R2011b/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/opt/emacs24/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set up the prompt

autoload -Uz promptinit
promptinit
# 下面这句会导致无法加载theme。
# prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# 容错。
zstyle ':completion::approximate:' max-errors 1 numeric

# 自动启动startx
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
    logout
fi

export PATH=/usr/local/MATLAB/R2011b/bin:$PATH
export PATH=$PATH:/opt/emacs24/bin
# bind Space:magic-space

# wine
export WINEPREFIX=$HOME/.wine
export WINEARCH=win32

# 使M-backspace回删一个词。
autoload -U select-word-style
select-word-style bash

# Some more ls aliases
alias pp='percol --match-method pinyin'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ag='ag --path-to-agignore=~/.agignore'
alias -s htm=firefox
alias -s html=firefox
alias -s el=emacsclient
alias -s py=emacsclient
alias -s js=emacsclient
alias -s c=emacsclient
alias -s h=emacsclient
alias -s java=emacsclient
alias -s m=emacsclient
alias -s dot=emacsclient
alias -s gp=emacsclient
alias -s org=emacsclient
alias -s tex=emacsclient
alias -s txt=emacsclient
alias -s rmvb=mplayer
alias -s rm=mplayer
alias -s mp4=mplayer
alias -s avi=mplayer
alias -s flv=mplayer
alias -s f4v=mplayer
alias -s mpg=mplayer
alias -s mkv=mplayer
alias -s 3gp=mplayer
alias -s wmv=mplayer
alias -s mov=mplayer
alias -s dat=mplayer
alias -s asf=mplayer
alias -s mpeg=mplaye
alias -s wma=mplayer
alias -s jpg="~/feh.sh"
alias -s png="~/feh.sh"
alias -s bmp="~/feh.sh"
alias -s jpeg="~/feh.sh"
alias -s eps=gv
alias -s ps=gv
alias -s doc=wps
alias -s docx=wps
alias -s xls=et
alias -s xlsx=et
alias -s ppt=wpp
alias -s pptx=wpp
alias -s pdf=llpp
# 载入percol相关函数。
source ~/.zsh_percol.sh