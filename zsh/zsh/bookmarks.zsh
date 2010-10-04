# File: bookmarks.zsh
# Brief: Bookmark functions
# Version: 1.0
# Author: Arkanosis <arkanosis@gmail.com>
#


typeset -A bookmarks

bookmarkentries=()
bookmarkcompletions=()

function s()
{
    bookmarkentries+=($1)
    bookmarks[$1]=`pwd`
    bookmarkcompletions+=($1:$bookmarks[$1])
}

function r()
{
    cd $bookmarks[$1]
}

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

    bookmarkentries=$newbookmarkentries
    bookmarkcompletions=$newbookmarkcompletions

    unset $bookmarks[$1]
}

function bk()
{
    for bookmark in $bookmarkentries; do
	echo "$bookmark\t$bookmarks[$bookmark]"
    done
}