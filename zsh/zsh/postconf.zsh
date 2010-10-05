# File: postconf.zsh
# Brief: Post Configuration file for zsh conf
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#

if ! [[ -d $ZSH_CONF_CACHE ]]; then
    mkdir -p $ZSH_CONF_CACHE
fi

# Create regularly used bookmarks
cd /goinfre && s goinfre
cd ~/.vim/ && s vimconf
cd ~/.zsh/ && s zshconf



