# Prompt file

ctime="white"
cvcs="red"
cpath="red"
cuser="yellow"
chost="green"
csept="cyan"
csepb="red"

#chost="green"
##chost="lightblue"
#cpath="blue"
#ctime="yellow"
#cvcs="green"
#crev="yellow"
g_branch=""

sub_dir() {
  local sub_dir
  sub_dir=$(readlink -f "${PWD}")
  sub_dir=${sub_dir#$1}
  echo ${sub_dir#/}
}

git_dir() {
	#base_dir=$(git rev-parse --show-cdup 2>/dev/null) || return 1
	base_dir="."
	while [ ! -d "$base_dir/.git" ]; do 
		base_dir="$base_dir/..";
		[ $(readlink -f "${base_dir}" || echo "/") = "/" ] && return 1; 
	done
	base_dir=$(readlink -f "$base_dir/")
	sub_dir=$(git rev-parse --show-prefix)
	sub_dir=${sub_dir%/}
	# FIXED: -q = wtf ??
	#ref=$(git symbolic-ref HEAD || git name-rev --name-only HEAD 2>/dev/null)
	ref=$(git symbolic-ref HEAD || git name-rev --name-only HEAD 2>/dev/null)
	ref=${ref#refs/heads/}
	vcs="git"
	export b=$ref
}

svn_dir() {
  [ -d ".svn" ] || return 1
  base_dir="."
  while [ -d "$base_dir/../.svn" ]; do base_dir="$base_dir/.."; done
  base_dir=$(readlink -f "$base_dir")
  sub_dir=$(sub_dir "${base_dir}")
  ref=$(svn info "$base_dir" | awk '/^URL/ { sub(".*/","",$0); r=$0 } /^Revision/ { sub("[^0-9]*","",$0); print r":"$0 }')
  vcs="svn"
}

hg_dir() {
  base_dir="."
  while [ ! -d "$base_dir/.hg" ]; do base_dir="$base_dir/.."; [ $(readlink -f "${base_dir}") = "/" ] && return 1; done
  base_dir=$(readlink -f "$base_dir")
  sub_dir=$(sub_dir "${base_dir}")
  ref=$(< "${base_dir}/.hg/branch")
  vcs="hg"
}

__vcs_dir() {
  local vcs base_dir sub_dir ref


  git_dir ||
  svn_dir ||
  hg_dir ||
  base_dir="$PWD"
  _path="%B%{$fg[$cpath]%}"
  _vcs="%b%{$fg[$cvcs]%}"
  _sep="%b%{$fg[$csept]%}"
  export b=$ref
  pwd="${_path}${base_dir/$HOME/~}${vcs:+${_sep}[${_vcs}$ref${_sep}]${_path}${sub_dir}}"
}

autoload -U colors
colors

precmd() {

prompt=">%{$fg[$ctime]%}"
time="%H:%M"
timestamp="%(?..%B%{$fg[$ctime]%}Err %?%b$clr )%{$fg[$cpath]%}| $clr%{$fg[$ctime]%}%B%D{$time}"

user="%B%{$fg[$cuser]%}%n"
host="%B%{$fg[$chost]%}%m"
__vcs_dir
pwd=$pwd
backn="\\n"
clr="%{$reset_color%}"

PS1="%{$pwd%}
42sh$ "
#$user$clr%{$fg[$csepb]%}@$host$clr%{$fg[$csepb]%}$prompt "
RPS1="$timestamp$clr"

# Term title
case $TERM in
  *xterm*|*rxvt*|(dt|k|E)term)
    print -Pn "\e]0;%n@%m:%~\a"
    #preexec () { print -Pn "\e]0;%n@%m:%~\a $1" }
  ;;
esac
}

# Term title
case $TERM in
  *xterm*|*rxvt*|(dt|k|E)term)
    preexec () { print -Pn "\e]0;%n@%m:%~ > $1\a" }
  ;;
esac
