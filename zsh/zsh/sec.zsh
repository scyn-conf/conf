# File: sec.zsh
# Brief: Zsh security configuration file
# Version: 0,1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#


function generate_password()
{
	cat /dev/random | tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+={}[]|",<>./?' | fold -w 12 | head -n 1
}
