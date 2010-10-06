# File: clean.zsh
# Brief: clean aliases and functions
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#


TRASHFILES='*~ #*~ *.sw[poa]'

function clean()
{
	for expr in `echo $TRASHFILES`; do
		find . -name "$expr" -delete
	done
}
