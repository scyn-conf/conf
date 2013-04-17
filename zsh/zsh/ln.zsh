# File: ln.zsh
# Brief: Zsh ln configuration file
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#

relink()
{
	unlink $1
	ln -s $2 $1
}
