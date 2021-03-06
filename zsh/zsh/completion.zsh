# File: completion.zsh
# Brief: Completion configuration for zsh conf
# Version: 1.0
# Author: Arkanosis <arkanosis@gmail.com>
#

typeset -U fpath

setopt auto_list
setopt complete_in_word
setopt hash_list_all
setopt list_types
setopt correct
setopt extended_glob

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zcache/zsh

fignore=(.aux .toc .bak .sav .old .o .trace \~)

fpath=($ZSH_CONF_DIR/zsh/completions $fpath)

autoload -U compinit
compinit -d $ZSH_CONF_CACHE/completion

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  '+m:{a}={á}' '+m:{e}={é}' \
  '+m:{a}={à}' '+m:{e}={è}' '+m:{u}={ù}' \
  '+m:{a}={â}' '+m:{e}={ê}' '+m:{i}={î}' '+m:{o}={ô}' '+m:{u}={û}' \
  '+m:{e}={ë}'

# Description des groupes de completion
s=`echo "\e[1;40m%d\e[0m"`
zstyle '*:descriptions' format $s
zstyle ':completion:*' group-name ''

# Autocomplète le globbing au lieu de l'étendre (utiliser shift+tab pour passer outre magic-tab, qui ne fait que l'expansion)
zstyle ':completion:*' completer _expand _complete _ignored

zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes

zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

zstyle ':completion:*:*:(x|t):*' file-patterns '*.(7z|bz2|deb|docx|gz|jar|lzma|rar|tar|tbz2|tgz|xpi|xz|zip|Z):files *(-/):directories'

compdef sc=screen
compdef v=vim

compdef _precommand runin

function zcl()
{
    if ((# != 1)); then
	echo 'Usage: zcl <command>' >&2
	return 1
    fi

    rm -f $ZSH_CONF_CACHE/$1
}

function magic-tab()
{
    if [[ -z $LBUFFER && -z $RBUFFER ]]; then
	LBUFFER+=./
    fi
    zle expand-or-complete
}
zle -N magic-tab
