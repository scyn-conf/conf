# File: postconf.zsh
# Brief: Post Configuration file for zsh conf
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#

if ! [[ -d $ZSH_CONF_CACHE ]]; then
    mkdir -p $ZSH_CONF_CACHE
fi

bk_read_cache
luksdrives_read_cache
trash_read_cache

