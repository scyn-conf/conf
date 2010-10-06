# File: zshrc.zsh
# Brief: Zsh configuration file
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>


pushd $0:h >&-

source ./alias.zsh
source ./arc.zsh
source ./backup.zsh
source ./bookmarks.zsh
source ./clean.zsh
source ./completion.zsh
source ./editor.zsh
source ./env.zsh
source ./env_kaneton.zsh
source ./history.zsh
source ./ls.zsh
source ./opt.zsh
source ./prompt.zsh
source ./rm.zsh
source ./ssh.zsh
source ./x.zsh
source ./zlock.zsh
source ./postconf.zsh

popd >&-
