# File: ls.zsh
# Brief: ls configuration and aliases file
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>


case `uname -s` in
	Darwin|FreeBSD)
		alias ls="ls -o -G --classify"
		;;
	*)
		alias ls="ls -o --color=auto --group-directories-first --classify --human-readable"
		;;
esac
alias la='ls -a'
alias l='ls'

# colors definitions
dark_black="30"
dark_red="31"
dark_green="32"
dark_yellow="33"
dark_blue="34"
dark_purple="35"
dark_cyan="36"
dark_white="37"
black="90"
red="91"
green="92"
yellow="93"
blue="94"
purple="95"
cyan="96"
white="97"

# format definitions (should precede color)
bold="1;"
italic="3;"
underline="4;"

# File system
LS_COLORS="di=$blue"
LS_COLORS+=":ln=$italic$dark_cyan"
LS_COLORS+=":ex=$red"
#LS_COLORS="di=$red"
#LS_COLORS+=":ln=$italic$blue"
#LS_COLORS+=":ex=$red"


# Code files
LS_COLORS+=":*.o=$dark_cyan"
LS_COLORS+=":*.h=$dark_green"
LS_COLORS+=":*.hh=$dark_green"
LS_COLORS+=":*.hpp=$dark_green"
LS_COLORS+=":*.c=$yellow"
LS_COLORS+=":*.C=$yellow"
LS_COLORS+=":*.cc=$yellow"
LS_COLORS+=":*.cpp=$yellow"
LS_COLORS+=":*.hxx=$yellow"

# Build
LS_COLORS+=":*Makefile=$dark_blue"
LS_COLORS+=":*SConscript=$dark_blue"
LS_COLORS+=":*CMakeList.txt=$dark_blue"
LS_COLORS+=":*configure=$dark_blue"
LS_COLORS+=":*.diff=$dark_cyan"

# Project related
LS_COLORS+=":*README=$green"
LS_COLORS+=":*NOTES=$green"
LS_COLORS+=":*INSTALL=$dark_cyan"
LS_COLORS+=":*TODO=$green"
LS_COLORS+=":*INFO=$dark_cyan"
LS_COLORS+=":*MANIFEST=$dark_cyan"
LS_COLORS+=":*ChangeLog=$dark_cyan"
LS_COLORS+=":*AUTHORS=$dark_cyan"
LS_COLORS+=":*CONTRIBUTORS=$dark_cyan"
LS_COLORS+=":*LICENSE=$dark_cyan"
LS_COLORS+=":*PKG-INFO=$dark_cyan"
LS_COLORS+=":*NEWS=$dark_cyan"
LS_COLORS+=":*COPYING=$dark_cyan"
LS_COLORS+=":*COPYRIGHT=$dark_cyan"

# archives
LS_COLORS+=":*.gz=$yellow"
LS_COLORS+=":*.bz2=$yellow"
LS_COLORS+=":*.tbz=$yellow"
LS_COLORS+=":*.tgz=$yellow"
LS_COLORS+=":*.7z=$yellow"
LS_COLORS+=":*.xz=$yellow"
LS_COLORS+=":*.zip=$yellow"

# misc files
LS_COLORS+=":*.log=$dark_cyan"
LS_COLORS+=":*.bak=$dark_purple"
LS_COLORS+=":*~=$dark_purple"
LS_COLORS+=":*#=$italic$dark_purple"
LS_COLORS+=":*tags=$dark_purple"
export LS_COLORS
