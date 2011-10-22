# File: env.zsh
# Brief: Zsh prompt configuration file
# Version: 1.0
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>

setopt prompt_subst

autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}✓'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}✗'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' get-revision true

setopt prompt_subst

export PROMPT_STYLE=complete
function switch_prompt()
{
	case `echo $PROMPT_STYLE` in
		complete)
			export PROMPT_STYLE=simple
		;;
		simple)
			export PROMPT_STYLE=complete
		;;
		*)
		;;
	esac
}

function active_jobs()
{
	nb_processes=`jobs | wc -l`
	if [ $nb_processes -eq 1 ]; then
		echo -n "[$nb_processes&]"
	elif [ $nb_processes -gt 1 ]; then
		echo -n "[$nb_processes&]"
	fi
}

function precmd()
{
	reset="%{`print "\e(B\e)B\e*B\e+B"`%}"
	dark_red="%{`print "\e[31m"`%}"
	dark_green="%{`print "\e[32m"`%}"
	dark_yellow="%{`print "\e[33m"`%}"
	dark_blue="%{`print "\e[34m"`%}"
	dark_purple="%{`print "\e[35m"`%}"
	dark_cyan="%{`print "\e[36m"`%}"
	dark_white="%{`print "\e[37m"`%}"
	red="%{`print "\e[91m"`%}"
	green="%{`print "\e[92m"`%}"
	yellow="%{`print "\e[93m"`%}"
	blue="%{`print "\e[94m"`%}"
	purple="%{`print "\e[95m"`%}"
	cyan="%{`print "\e[96m"`%}"
	white="%{`print "\e[97m"`%}"
	clr="%{$reset_color%}"

	if `vcs_info >&-`; then
		if [ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]; then
			zstyle ':vcs_info:*' formats "$dark_cyan%s:%b:%7.7i$clr" "%c%u"
		else
			zstyle ':vcs_info:*' formats "$dark_cyan%s:%b:%7.7i$clr" "%c%u%F${red}?$dark_cyan"
		fi
		vcs_info
	fi
	case $TERM in
		*xterm*|*rxvt*|Eterm)
		echo -ne "\e]0;${HOST%%.*}:${PWD/$HOME/~} $vcs\007"
		;;
		screen*)
		echo -ne "\033]0;${HOST%%.*}:${PWD/$HOME/~} $vcs\007\033k`basename $PWD`\033\\"
		;;
	esac

	case `echo $PROMPT_STYLE` in
		complete)
PROMPT="$yellow%D{%H:%M}$clr - Logged as $green$USER$clr on $red$HOST$clr in $blue%~$clr ${vcs_info_msg_1_}
$(active_jobs)%(?..${red}[%?] %b)$dark_cyan(%!) ${dark_blue}42sh>$clr "
RPROMPT="${vcs_info_msg_0_}$clr"
		;;
		simple)
RPROMPT="${vcs_info_msg_0_}$yellow [%D{%H:%M}]"
PROMPT="%(?..$red}[%?] %b)$blue%~ ${vcs_info_msg_1_}
$green$USER$clr@$red$HOST$clr: "
		;;
		*)
		;;
	esac
}



autoload -U colors
colors

# Affiche le texte, meme s'il n'y a pas de retour a la ligne
setopt nopromptcr
#
