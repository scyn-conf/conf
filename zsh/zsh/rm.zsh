# File: rm.sh
# Brief: Zsh rm configuration and alias file
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#

TRASH=$HOME/.trash

# Overrides rm default behavior by creating a trash directory
rm ()
{
	# If the trash does not exist, create it
	if [ ! -e $TRASH ]; then
		mkdir $TRASH
	fi

	# for each argument
	for file in $@; do
		filename=`basename $file`
		# if the file already exists in the trash, modify filename
		if [ -e $TRASH/$filename ]; then
			filename=$filename-`ls $TRASH/ | grep $filename | wc -l | sed 's/[ \t]//g'`
		fi
		mv $file $TRASH/$filename
	done
}

empty_trash()
{
	if [ -e $TRASH ]; then
		 /bin/rm -rf $TRASH
	fi
}
