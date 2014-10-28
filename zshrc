########################################
# ~/.zshrc
# Settings for zsh
#
# Sections:
#   -> Start-up
#   -> General
#   -> Aliases, shortcuts
#   -> Functions
########################################


########################################
# => Start-up
########################################
# Load and run compinit
autoload -U compinit
compinit -i -d "${ZSH_COMPDUMP}"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="steeef"
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
source $ZSH/oh-my-zsh.sh

# User configuration

# Don't prompt when using rm
# That's what rm -i is for
setopt no_rm_star_silent

export TERM=xterm-256color
export PATH=$PATH:$HOME/bin:/usr/local/bin

export EDITOR='vim'

source ~/.dotfiles/aliases

# Get ls to play nicely with solarized
if [[ ! -d ~/.dircolors ]]; then
    echo "Retrieving dircolors..."
    git clone https://github.com/seebi/dircolors-solarized.git  ~/.dircolors
fi
    eval $(dircolors ~/.dircolors/dircolors.ansi-dark)

# Fast switching to a background task
# Credit goes to http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z