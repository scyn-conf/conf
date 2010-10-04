# File: editor.zsh
# Brief: Zsh configuration file for editors (env variables and aliases)
# Version: 1.0
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#

if which vim >& /dev/null; then
   export EDITOR='vim'
else
   export EDITOR='vi'
fi

export VIM_SERVER=`openssl rand -base64 20`
alias vs="gvim --servername $VIM_SERVER --remote "
alias v="gvim --servername 1 --remote "

