# File: env_epita.zsh
# Brief: Zsh env configuration file for epita (PIE/PILA)
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#

export LOGIN='chaint_r'
export EMAIL='$LOGIN@epita.fr'
export SOCKS_PASSWORD=`cat $HOME/.socks`
export TSOCKS_PASSWORD=$SOCKS_PASSWORD
export TSOCKS_USERNAME=$LOGIN
export NNTPSERVER='news.epita.fr'


