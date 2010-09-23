# File: zshrc
# Brief: Zsh configuration file
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>

case $HOST in
	lisp|caml|ruby|ada|php|asp|sh|java|apl|pascal)
		# nothing to be done
	;;
	A.Bettik)
		alias zlock='slock'
	;;
	Consul)
		# FIXME
	;;
	*)
		if /usr/school/bin/ns_who >&-; then

			alias zlock="/usr/bin/zlock -immed -notime		\
			-text \"-<(              $PSEUDO              )>-\"	\
			-pwtext '> unlock ! < ... > I said... UNLOCK!    '"
		fi
	;;
esac


