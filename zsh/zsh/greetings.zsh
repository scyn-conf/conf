# File: greetings.zsh
# Brief: greeting function to run at the end of zsh configuration loading
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#
# Yeah, art!
function greetings()
{
	$ZSH_CONF_DIR/zsh/scripts/colors.sh
	# Greeting message
	echo -e	"\033[94mLogged in on \033[33m`date "+%d/%m/%y"`\033[0m \033[94mat \033[33m`date "+%l:%M"`\033[0m"
	echo -e "\033[94m`uname -a`\n\033[0m"
	echo -e "Welcome on \033[34m$HOST\033[0m, \033[32m$PSEUDO\033[0m.\n"
}
