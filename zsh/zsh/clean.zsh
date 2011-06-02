# File: clean.zsh
# Brief: clean aliases and functions
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#


TRASHFILES='*~ #*~ *.sw[poa]'

function clean()
{
    rm -f *.o(n)
    rm -f *.aux(n)
    rm -f *.log(n)
    rm -f *.toc(n)
    rm -f *~(n)
    rm -f .*~(n)
    rm -f \#*\#(n)
}

function rclean()
{
	for expr in `echo $TRASHFILES`; do
		find . -name "$expr" -delete
	done
}

alias clrn="clean; clear"
