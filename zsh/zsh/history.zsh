# File: zshrc
# Brief: Zsh history configuration file
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>


setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt APPEND_HISTORY

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

