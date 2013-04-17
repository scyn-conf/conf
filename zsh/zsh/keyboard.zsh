# File: keyboard.zsh
# Brief: Zsh keyboard layout configuration file
# Version: 1.0
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>


KB_LAYOUT='us'
# change keyboard layout between defined keyboards
function ck()
{
	case $KB_LAYOUT in
		us)
			KB_LAYOUT='us_intl'
			setxkbmap us_intl
			;;
		us_intl)
			KB_LAYOUT='us'
			setxkbmap us
			;;
	esac
}

# function used by the prompt to display current keyboard layout
function keyboard_layout()
{
	layout=`setxkbmap -query | grep layout | awk '{print $2;}'`
	echo -n "[$layout]"
}


