# File: backup.zsh
# Brief: Backup function
# Version: 1.0
# Author: Arkanosis <arkanosis@gmail.com>
#


function bak()
{
    if ! ((#)); then
	echo 'Usage: bak <files>' >&2
	return 1
    fi

    for file; do
	cp -riv --backup=numbered $file $file-`date +%Y-%m-%d.bak`
    done
}


function unbak()
{
    if ! ((#)); then
	echo 'Usage: unbak <files>' >&2
	return 1
    fi

    for file; do
	mv $file `echo $file | sed 's/-201.*//g'`
    done
}
