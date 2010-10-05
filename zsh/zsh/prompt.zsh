# File: env.zsh
# Brief: Zsh prompt configuration file
# Version: 1.0
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>


setopt prompt_subst

autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}✔'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}✘'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' get-revision true

setopt prompt_subst

function precmd()
{
	reset="%{`print "\e(B\e)B\e*B\e+B"`%}"
	white="%{`print "\e[37;1m"`%}"
	lwhite="%{`print "\e[37m"`%}"
	yellow="%{`print "\e[33m"`%}"
	lyellow="%{`print "\e[33;1m"`%}"
	red="%{`print "\e[31m"`%}"
	lred="%{`print "\e[31;1m"`%}"
	green="%{`print "\e[32m"`%}"
	lgreen="%{`print "\e[32;1m"`%}"
	blue="%{`print "\e[34m"`%}"
	lblue="%{`print "\e[34;1m"`%}"
	purple="%{`print "\e[35m"`%}"
	lpurple="%{`print "\e[35;1m"`%}"
	dirt="%{`print "\e[36m"`%}" # cyan
	ldirt="%{`print "\e[36;1m"`%}"
	clr="%{$reset_color%}"



	
	if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
		zstyle ':vcs_info:*' formats "[%s:%b:%r]%c%u"
	} else {
		zstyle ':vcs_info:*' formats "[%s:%b:%r]%c%u%F{red}✗"
	}

	vcs_info
	
	case $TERM in
		*xterm*|*rxvt*|Eterm)
		echo -ne "\e]0;${HOST%%.*}:${PWD/$HOME/~} $vcs\007"
		;;
		screen*)
		echo -ne "\033]0;${HOST%%.*}:${PWD/$HOME/~} $vcs\007\033k`basename $PWD`\033\\"
		;;
	esac
	
	PROMPT="${blue}%~${dirt} ${vcs_info_msg_0_}$clr
${dirt}$USER${yellow}@${dirt}$HOST${blue} 42sh> ${clr}"
	RPROMPT="${blue}<%! $clr%(?..${red}[%?]%b)${green}[%D{%H:%M}]${clr}"


}

autoload -U colors
colors

# Affiche le texte, meme s'il n'y a pas de retour a la ligne
setopt nopromptcr
#
