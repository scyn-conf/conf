# File: rm.sh
# Brief: Zsh rm configuration and alias file
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#

TRASH=$HOME/.trash

typeset -A trashfiles
trashentries=()
trashcompletions=()

# Overrides rm default behavior by creating a trash directory
rm()
{
	# If the trash does not exist, create it
	if [ ! -e $TRASH ]; then
		mkdir $TRASH
	fi

	# for each argument
	for file in $@; do
		filename=$file-`date +%Y-%m-%d_%Hh%m`.trash
		mv $file $TRASH/$filename
		echo "$file -> $TRASH/$filename"
		trashentries+=($filename)
		trashfiles[$filename]=`pwd`/$file
		trashcompletions+=($filename:$trashfiles[$filename])
	done
}

rs()
{
	src=$1
	newtrashentries=()
	newtrashcompletions=()

	for file in $trashentries; do
		if [[ $file != $src ]]; then
			newtrashentries+=($file)
			newtrashcompletions+=($file:$trashfiles[$file])
		else
			dst=$trashfiles[$src]
			echo "$src -> $dst"
			mv -i $TRASH/$src $dst
		fi
	done

	trashentries=($newtrashentries)
	trashcompletions=($newtrashcompletions)

	unset $trashfiles[$src]
}

show_trash()
{
	for file in $trashentries; do
		echo "$file\t$trashfiles[$file]"
	done
}

empty_trash()
{
	if [ -e $TRASH ]; then
		 /bin/rm -rf $TRASH
	fi
}
