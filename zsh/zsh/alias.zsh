#alias gvim="~/src/mvim --remote-tab-silent"
#
export VIM_SERVER=`openssl rand -base64 20`
alias v="gvim --servername $VIM_SERVER --remote "
alias vs="gvim --servername 1 --remote "
alias vall=f_vall 
function f_vall ()
{
	for arg in $*; do
		v `find . -name "$arg"`
	done;
}
alias p="popd"
alias c="dirs -c"

alias f="find . -iname "

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias g="egrep --color=auto -i"
alias gr="egrep --color=auto -Rin"
#
#alias ls="ls -l --color=auto"
#alias la="ls -la --color=auto"
#
alias -g L=" | less -R"

#alias rm='rm -i'
alias clean='rm -f *~ *\#* *.o *.so *.a .*~ 2> /dev/null'
alias clean-tex='rm -f *log *out *snm *toc *nav *aux'
alias gccc='gcc -W -Wall -Werror -ansi -pedantic -g -L/usr/pkg/lib -lefence'

alias msdb1="sudo mount /dev/sdb1 /media/sdb1"
alias msdb2="sudo mount /dev/sdb2 /media/sdb2"
alias msda1="sudo mount /dev/sda1 /media/sda1"
alias msda2="sudo mount /dev/sda2 /media/sda2"
alias umsdb1="sudo umount /dev/sdb1"
alias umsdb2="sudo umount /dev/sdb2"
alias umsda1="sudo umount /dev/sda1"
alias umsda2="sudo umount /dev/sda2"

alias g="git"

#~~~~ Olfeo aliases
# Reconfigure /etc/resolv.conf
alias resolv='sudo ~/.bin/resolv.py'
# Reconfigure default gateways
alias reroute='~/.bin/reroute.sh'

gdist ()
{
  base_dir="."
  while [ ! -d "$base_dir/.git" ]; do base_dir="$base_dir/.."; [ $(readlink -f "${base_dir}") = "/" ] && return 1; done
  base_dir=$(readlink -f "$base_dir/")
  git-archive --format=tar HEAD | gzip -c > `basename $base_dir`.tgz
  echo $base_dir.tgz
}

o ()
{
  if [ $# -eq 0 ]
  then
    open .
  else
    open $@
  fi
}

alias q="/work/git/ktools/q.sh"
alias qg="/work/git/ktools/qg.sh"
alias ik="/work/git/ktools/install_kernel.sh"
alias kq="sudo killall qemu"

nc_send ()
{
	if [ "$#" -eq 2 ]; then
		my_path="$1"
		my_port="$2"
	elif [ "$#" -eq 1 ]; then
		my_path="$1"
		my_port=6666
	else
		echo "nc_send \$path [\$port]"
		return
	fi
	tar -cf - $my_path | pv | nc -l -p $my_port -q 5
}

nc_recv ()
{
	if [ "$#" -eq 2 ]; then
		my_ip="$1"
		my_port="$2"
	elif [ "$#" -eq 1 ]; then
		my_ip="$1"
		my_port=6666
	else
		echo "nc_recv $ip [$port]"
		return
	fi
	nc $my_ip $my_port | pv | tar -xf -
}
alias ct=~/conf/colors.pl


#alias spark='tsocks ssh scyn@$IPSPARK'
alias ssh_epita='ssh chaint_r@ssh.epita.fr'


alias ack-grep='~/bin/ack-standalone'
alias netsoul='~/bin/netsoul-connect.py&'


