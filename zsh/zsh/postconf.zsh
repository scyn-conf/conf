# File: postconf.zsh
# Brief: Post Configuration file for zsh conf
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#

if ! [[ -d $ZSH_CONF_CACHE ]]; then
    mkdir -p $ZSH_CONF_CACHE
fi

bookmarks_file=~/.zsh_bookmarks

if [ -e $bookmarks_file ]; then
	for line in `cat $bookmarks_file`; do
		bk_name=`echo "$line" | sed -e 's/:.*//g'`
		bk_path=`echo "$line" | sed -e 's/.*://g'`
		echo "$bk_name:$bk_path"
		cd $bk_path && s $bk_name
	done
fi



