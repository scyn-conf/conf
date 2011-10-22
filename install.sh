#! /bin/bash

###############################################################################
# Script Variables and usage

ALL=true
FORCE=false
UNINSTALL=false
CLEAN=false

VIM=false
AWESOME=false
GIT=false
X=false
ZSH=false
APT=false

SOPTS="fhuc"
LOPTS="force,help,uninstall,clean,apt,awesome,git,vim,X,zsh"

INSTALL_PATH=`pwd`/`dirname $0 | sed 's/^.\///g'`
while echo $INSTALL_PATH | grep '\.\.' > /dev/null; do
	INSTALL_PATH=`echo $INSTALL_PATH | sed 's_/\./_/_g ; s_/[^/]\+/\.\./_/_g ; s_/[^/]\+/..$__'`
done

BLUE="\033[34m"
LBLUE="\033[94m"
RED="\033[31m"
LRED="\033[91m"
YELLOW="\033[33m"
LYELLOW="\033[93m"
GREEN="\033[32m"
LGREEN="\033[92m"
RST="\033[0m"

executable=`basename $0`
usage ()
{
	cat << EOF
Usage: $executable [options] [arguments]
This script is intended to provide easy installation / backup / restoration for
configuration files.
In the case no arguments are given, all configuration files will be installed.


Options:
	-c, --clean     remove backup files
	-f, --force	existing configuration files are overwritten
	-h, --help	display help
	-u, --uninstall restore previously saved configuration

Arguments:
	--apt		apt configuration files
	--awesome	awesome configuration files
	--git		git configuration files
	--vim		vim configuration files
	--X		X configuration files
	--zsh		zsh configuration files

Report bug at <remi.chaintron+bug@gmail.com>
EOF
}


###############################################################################
# Functions

# Function: installation ()
# Create symlink between arguments. The function also creates a backup of
# previously existing files, update existing symlinks if necessary and prompt
# user for permission to overwrite olf backup files when needed.
# args:
# - src: the path the link will lead to
# - dst: where the link should appear
installation ()
{
	# vars
	SRC=$INSTALL_PATH/$1
	DST=$2
	# get save name, prefix it with a dot if necessary
	SAVE=`dirname $DST`/`basename "$DST.conf-backup" | sed 's/^.//g; s/^/./g'`
	# if force option, delete backup file
	if [ $FORCE == true ]; then
		rm -rf $DST
		echo -e "${YELLOW}Deleting existing $DST${RST}"
	else
		# Case 1 : if a backup exists, prompt user for overwrite.
		if [ -e $SAVE ]; then
			echo -n "$SAVE file already exists, do you want to overwrite it?  (y/N)[N]"
			read ANSWER
			if [ "x$ANSWER" != "xy" ]; then
				echo -e "${YELLOW}Stopping $DST installation${RST}"
				return
			else
				echo "Overwriting $SAVE"
			fi
		fi
		# if the configuration file exists and is not a symlink, save it
		if [ -e $DST -a ! -L $DST ]; then
			mv $DST $SAVE
			echo "Saved $DST to $SAVE"
		# else, if it is a symlink, update it if necessary
		elif [ -e $DST ]; then
			# get target
			target=`readlink $DST`
			if [ "$target" != "$SRC" ]; then
				mv $DST $SAVE
				echo "Changed symlink $DST -> $target to $DST -> $SRC"
			else
				echo "Symlink is up-to-date, nothing to do"
				return
			fi
		fi
	fi
	# if configuration file does not exist, link it
	if [ ! -e $DST ]; then
		ln -s $SRC $DST
		echo -e "${GREEN}$DST successfully installed ${RST}"
	else
		echo -e "${LRED}$DST already exists${RST}"
	fi
}

# Function: uninstallation ()
# Uninstall argument configuration files, restoring last backup if possible
# args:
# - dst: the configuration file to uninstall
uninstallation ()
{
	# vars
	DST=$1
	SAVE=`dirname $DST`/`basename "$DST.conf-backup" | sed 's/^.//g; s/^/./g'`
	if [ -e $SAVE ]; then
		mv $SAVE $DST
		echo "Restored $SAVE to $DST"
	else
		rm -rf $DST
		echo "Erased $DST"
	fi
}

# Function: clean_backup ()
# Remove backup files for argument configuration file
# args:
# - dst: the configuration file used to retrieve its related backup
clean_backup ()
{
	DST=$1
	SAVE=`dirname $DST`/`basename "$DST.conf-backup" | sed 's/^.//g; s/^/./g'`
	if [ -e $SAVE ]; then
		rm -rf $SAVE
		echo "Removed $SAVE"
	fi
}

# Function: perform_action ()
# Perform action according to script arguments. Possible actions include
# installation, uninstallation and clean.
# args
# - do: a boolean indicating whether something has to be done
# - src: source configuration file
# - dst: destination configuration file
perform_action ()
{
	DO=$1
	SRC=$2
	DST=$3
	if [ $DO == true -o $ALL == true ] ; then
		if [ $CLEAN == true ]; then
			clean_backup $DST
		elif [ $UNINSTALL == false ]; then
			installation $SRC $DST
		else
			uninstallation $DST
		fi
	fi
}


###############################################################################
# Args handling

# Getopt
if $(getopt -T >/dev/null 2>&1) ; [ $? = 4 ] ; then
    OPTS=$(getopt -o $SOPTS --long $LOPTS -n "$executable" -- "$@")
else
    OPTS=$(getopt $SOPTS "$@")
fi
eval set -- "$OPTS"
while [ $# -gt 0 ]; do
	case $1 in
		-h|--help) usage; exit;;
		-f|--force) FORCE=true; shift;;
		-u|--uninstall) UNINSTALL=true; shift;;
		-c|--clean) CLEAN=true; shift;;
		--apt) APT=true; ALL=false; shift;;
		--awesome) AWESOME=true; ALL=false; shift;;
		--git) GIT=true; ALL=false; shift;;
		--vim) VIM=true; ALL=false; shift;;
		--X) X=true; ALL=false; shift;;
		--zsh) ZSH=true; ALL=false; shift;;
		--) break;;
		*) echo -e "${RED}Error: Invalid argument $1${RST}"; exit 1;;
	esac
done


###############################################################################
# Functions

# Vim configuration files
perform_action $VIM vim/vimrc ~/.vimrc
perform_action $VIM vim/vim ~/.vim

# git configuration file
perform_action $GIT git/gitconfig ~/.gitconfig

# zsh configuration files
perform_action $ZSH zsh/zsh ~/.zsh
perform_action $ZSH zsh/zshrc ~/.zshrc

case `uname -s` in
	Linux)
		# awesome configuration file
		perform_action $AWESOME awesome/awesomerc ~/.awesomerc.lua
		if ! [ -e ~/.config ]; then
			mkdir ~/.config
		fi
		perform_action $AWESOME awesome/awesome ~/.config/awesome

		# X init scripts
		perform_action $X X/xinitrc ~/.xinitrc
		perform_action $X X/xinitrc ~/.xsession
		perform_action $X X/Xdefaults ~/.Xdefaults
	;;
	*)
	;;
esac
