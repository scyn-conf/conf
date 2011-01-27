# File: rm.sh
# Brief: Zsh rm configuration and alias file
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#

TRASH=$HOME/.trash
TRASH_CACHE=$ZSH_CONF_CACHE/trash

typeset -A trashfiles
trashentries=()
trashcompletions=()

# Overrides rm default behavior by creating a trash directory
function rm()
{
	# If the trash does not exist, create it
	if [ ! -e $TRASH ]; then
		mkdir $TRASH
	fi

	# for each argument
	for file in $@; do
		# if file exists
		if [ -e $file ]; then
			# build destination name
			dest=`basename $file`-`date +%Y-%m-%d_%Hh%m`.trash
			src=$file

			# move file to trash
			mv $src $TRASH/$dest
			echo "$src -> $dest"

			# Store informations for restoration
			trashentries+=($dest)
			trashfiles[$dest]=`pwd`/$src
			trashcompletions+=($dest:$trashfiles[$dest])
			echo "$dest:$trashfiles[$dest]" >> $TRASH_CACHE
		fi
	done
}

# restore trash file, providing completion.
function rs()
{
	src=$1
	newtrashentries=()
	newtrashcompletions=()
	# Reset trash cache
	/bin/rm -rf $TRASH_CACHE

	# for each argument
	for file in $trashentries; do
		# if it isn't the restored file
		if [[ `basename $file` != $src ]]; then
			# store informations
			newtrashentries+=($file)
			newtrashcompletions+=($file:$trashfiles[$file])
			echo "$file:$trashfiles[$file]" >> $TRASH_CACHE
		else
			# restore file
			dst=$trashfiles[$src]
			echo "$src -> $dst"
			mv -i $TRASH/$src $dst
		fi
	done

	# Update stored informations
	trashentries=($newtrashentries)
	trashcompletions=($newtrashcompletions)
	unset $trashfiles[$src]
}

# display trash content
function st()
{
	for file in $trashentries; do
		echo "$file\t$trashfiles[$file]"
	done
}

# empty trash
function et()
{
	if [ -e $TRASH ]; then
		 /bin/rm -rf $TRASH
		 /bin/rm -rf $TRASH_CACHE
	fi
	for entry in $trashentries; do
		unset $trashfiles[$entry]
	done
	trashentries=()
	trashcompletions=()
}

# read trash cache (to be called at startup)
function trash_read_cache()
{
	if [ -e $TRASH_CACHE ]; then
		for entry in `cat $TRASH_CACHE`; do
			trashfile=${entry%:*}
			original=${entry##*:}
			trashentries+=($trashfile)
			trashfiles[$trashfile]=$original
			trashcompletions+=($trashfile:$trashfiles[$trashfile])
		done
	fi
}
