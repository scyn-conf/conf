## Prompt file
#
ctime="white"
cvcs="blue"
cpath="green"
cuser="red"
chost="red"
csept="cyan"
csepb="green"

setopt prompt_subst

if ((EUID == 0)); then
    PROMPT_COLOR=red
fi

function precmd()
{
	time="%H:%M"
	timestamp="%(?..%B%{$fg[$ctime]%}Err %?%b$clr )%{$fg[$cpath]%}| $clr%{$fg[$ctime]%}%B%D{$time}"

    local base_dir branch

    vcs=''
    if [[ -d .svn ]] ; then
        vcs="[svn:`svn info | grep Revision | sed 's/.* \(.*\)/\1/g'`]"
    fi
    base_dir='.'
    while [[ ! -d $base_dir/.hg && ! -d $base_dir/.git && `readlink -f $base_dir` != / ]]; do
	base_dir=$base_dir/..
    done
    if [[ -d $base_dir/.hg/ ]]; then
	if [[ -f $base_dir/.hg/branch ]]; then
            vcs="${vcs}[hg:`< $base_dir/.hg/branch`:`hg id -n`]"
	else
            vcs="${vcs}[hg:default:`hg id -n`]"
	fi
    elif [[ -d $base_dir/.git/ ]]; then
	branch=`git branch`
	if git describe --always >& /dev/null; then
            vcs="${vcs}[git:$branch[3,-1]:`git describe --always`]"
	else
            vcs="${vcs}[git:uncommited]"
	fi
    fi

    case $TERM in
 	*xterm*|*rxvt*|Eterm)
	    echo -ne "\e]0;${HOST%%.*}:${PWD/$HOME/~} $vcs\007"
 	;;
 	screen*)
	    echo -ne "\033]0;${HOST%%.*}:${PWD/$HOME/~} $vcs\007\033k`basename $PWD`\033\\"
 	;;
    esac

reset="%{`print "\e(B\e)B\e*B\e+B"`%}"
white="%{`print "\e[37;1m"`%}"
gray="%{`print "\e[37m"`%}"
yellow="%{`print "\e[33m"`%}"
lyellow="%{`print "\e[33;1m"`%}"
red="%{`print "\e[31m"`%}"
lred="%{`print "\e[31;1m"`%}"
green="%{`print "\e[32m"`%}"
lgreen="%{`print "\e[32;1m"`%}"
blue="%{`print "\e[34m"`%}"
lblue="%{`print "\e[34;1m"`%}"
purple="%{`print "\e[35m"`%}"
lgreen="%{`print "\e[35;1m"`%}"
cyan="%{`print "\e[36m"`%}"
lcyan="%{`print "\e[36;1m"`%}"
clr="%{$reset_color%}"


PROMPT="${yellow}$HOST${clr}${yellow}:%~${yellow}$vcs${clr}
${yellow}($clr$lyellow%!$clr${yellow})$clr${yellow}42sh${yellow}$ $clr"
RPROMPT="%(?..${red}Err %?%b$clr )| ${yellow}%D{%H:%M}${clr}"

}

autoload -U colors
colors

# Affiche le texte, meme s'il n'y a pas de retour a la ligne
setopt nopromptcr
#
