# File: ls.zsh
# Brief: ls configuration and aliases file
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>


case `uname -s` in
	Darwin|FreeBSD)
		alias ls="ls -o -G -p -F"
		;;
	*)
		alias ls="ls -o --color=auto --group-directories-first -p -F"
		;;
esac
alias la='ls -a'


export LS_COLORS='di=0;34:ln=3;33:ex=91:*~=90:*#=3;36:*README=1;33:*NOTES=33:*INSTALL=33:*TODO=33:*INFO=33:*ChangeLog=33:*AUTHORS=33:*CONTRIBUTORS=33:*LICENSE=33:*PKG-INFO=33:*NEWS=33:*COPYING=33:*COPYRIGHT=33:*Makefile=95:*SConscript=95:*CMakeList.txt=95:*.o=36:*.h=33:*.c=93:*.hh=33:*.hpp=33:*.cc=93:*.cpp=93:*.hxx=93:*.exa=1;95:*.java=35:*.tar=96:*.gz=96:*.bz2=96:*.tbz=96:*.tgz=96:*.7z=96:*.lzma=96:*.xz=96:*.zip=96:*.=1;91:*.xml=92:*.php=92:*.log=90:*.bak=90'

