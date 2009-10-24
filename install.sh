#! /bin/sh

installPath=`pwd`/`dirname $0 | sed 's/^.\///g'`
while echo $installPath | grep '\.\.' > /dev/null; do
	installPath=`echo $installPath | sed 's_/\./_/_g ; s_/[^/]\+/\.\./_/_g ; s_/[^/]\+/..$__'`
done


install ()
{
	test -e "$2" && printf "\033[31m$2 already exist, skipped\033[0m\n" \
	|| (ln -s "$installPath/$1" "$2" && printf "\033[32m$2 succefully installed\033[0m\n")
}

# Vim configuration files
install vim/vimrc ~/.vimrc
install vim/vim ~/.vim

# git configuration file
install git/gitconfig ~/.gitconfig

# zsh configuration files
install zsh/zsh ~/.zsh
install zsh/zshrc ~/.zshrc

# awesome configuration file
install awesome/rc.lua ~/.awesomerc.lua

# X init scripts
install X/xinitrc ~/.xinitrc
install X/xinitrc ~/.xsession
install X/Xdefaults ~/.Xdefaults
