# File: ls.zsh
# Brief: ls configuration and aliases file
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>


case `uname -s` in
	Darwin)
		alias ls="ls -o -G -p -F"
		;;
	*)
		alias ls="ls -o --color=auto -p -F"
		;;
esac
alias la='ls -a'
