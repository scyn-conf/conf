# File: opt.zsh
# Brief: Zsh configuration file - options
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>



# vi cmdline
setopt VI
bindkey -M viins jj vi-cmd-mode
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward


