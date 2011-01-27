# File: bookmarks.zsh
# Brief: Bookmarks functions for zsh conf
# Version: 1.0
# Author: Arkanosis <arkanosis@gmail.com>
#
#
typeset -A bookmarks
bookmarkentries=()
bookmarkcompletions=()
BOOKMARKS_CACHE=$ZSH_CONF_CACHE/bookmarks

# save bookmark
function s()
{
    bookmarkentries+=($1)
    bookmarks[$1]=`pwd`
    bookmarkcompletions+=($1:$bookmarks[$1])
}

# go to bookmark
function g()
{
    cd $bookmarks[$1]
}

# delete bookmark
function d()
{
    newbookmarkentries=()
    newbookmarkcompletions=()

    for bookmark in $bookmarkentries; do
	if [[ $bookmark != $1 ]]; then
	    newbookmarkentries+=($bookmark)
	    newbookmarkcompletions+=($bookmark:$bookmarks[$bookmark])
	fi
    done

    bookmarkentries=($newbookmarkentries)
    bookmarkcompletions=($newbookmarkcompletions)
    unset $bookmarks[$1]
}

# show bookmarks
function bk()
{
    for bookmark in $bookmarkentries; do
	echo "$bookmark\t$bookmarks[$bookmark]"
    done
}

# read bookmark cache file
function bk_read_cache()
{
	if [ -e $BOOKMARKS_CACHE ]; then
		for line in `cat $BOOKMARKS_CACHE`; do
			bk_name=${line%:*}
			bk_path=${line##*:}
			cd $bk_path && s $bk_name
		done
	fi
}
