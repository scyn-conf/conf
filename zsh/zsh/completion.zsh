# File: zshrc
# Brief: Zsh completion configuration file
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>

# Comp init
autoload -U compinit
compinit

# comp prompt
unsetopt list_ambiguous	  # mode
setopt auto_remove_slash  # remove slash if it's at then end of the line
#setopt glob_dots	  # include '.*' in comp
setopt chase_links	  # follow symlinks

# kill/killall
zstyle ':completion:*:processes-names' command 'ps -e -o comm='
zstyle ':completion:*:processes' command 'ps -au$USER'

# Correction
setopt correctall


