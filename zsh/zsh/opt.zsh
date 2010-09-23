# File: opt.zsh
# Brief: Zsh configuration file - options
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>


setopt BASH_AUTO_LIST
setopt CDABLE_VARS
setopt MARK_DIRS
setopt NULL_GLOB
setopt NO_MENU_COMPLETE
setopt NO_AUTO_MENU
setopt AUTO_CD
setopt AUTO_PUSHD
setopt NO_IGNORE_EOF
setopt NO_CASE_GLOB

# vi cmdline
setopt VI
bindkey -M viins jj vi-cmd-mode
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward


