# File: games.zsh
# Brief: Games aliases configuration file
# Version: 0.1
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>

function alias_game()
{
	game_path=$1
	game_alias=$2
	if [ -e $game_path ]; then
		alias $game_alias="$game_path"
	fi
}



alias_game  /usr/local/games/Dustforce/Dustforce.bin.x86_64 dustforce
