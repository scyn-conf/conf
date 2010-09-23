# File: epita.zsh
# Brief: Zsh configuration file for epita
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>

# env variables
export HOST='`/usr/school/bin/ns_who >&-`'
export LOGIN='chaint_r'
export PSEUDO="Scyn"
export EMAIL='chaint_r@gmail.com'
export SOCKS_PASSWORD='*utBB;u*'
export TSOCKS_PASSWORD=$SOCKS_PASSWORD
export TSOCKS_USERNAME=$LOGIN
export NNTPSERVER='news.epita.fr'

# Greetings

echo -e	"[`date "+%d/%m/%y  %l:%M"`] Welcome on PIE, $PSEUDO."

# ssh/scp aliases to use tsocks
alias ssh='tsocks ssh'
alias scp='tsocks scp'

# zlock
function zlock()
{
    /usr/bin/zlock -immed -notime					\
		   -text "-<(              $PSEUDO              )>-"	\
		   -pwtext '> unlock ! < ... > I said... UNLOCK!    '
}

