# File: epita.zsh
# Brief: Zsh configuration file for epita
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>

# env variables
source ./env_epita.zsh
export HOST='`/usr/school/bin/ns_who >&-`'

# Greetings
echo -e	"[`date "+%d/%m/%y  %l:%M"`] Welcome on PIE, $PSEUDO."

# get sm
case $HOST in
	freebsd*|gate-ssh*)
		host=`/usr/school/bin/ns_who -h $LOGIN | grep '10.200' | head -n 1 | sed -e 's/.*10\.200\.\([0-9]*\)\..*/\1/g'`
		export HOST="sm$host"
		;;
	*)
		;;
fi

