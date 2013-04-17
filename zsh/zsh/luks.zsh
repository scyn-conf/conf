# File: luks.zsh
# Project: 
# Brief:
# Version:	
# Author: Scyn - Remi Chaintron <remi.chaintron@gmail.com>
#

typeset -A luksdrives
luksdrives_entries=()
luksdrives_completions=()
LUKSDRIVES_CACHE=$ZSH_CONF_CACHE/luks


# mount luks drive
function luks_mount()
{
	# get name and path
	luksdrive_name=$1	
	luksdrive_path=$luksdrives[$luksdrive_name]
	# open and mount drive
	sudo cryptsetup luksOpen $luksdrive_path $luksdrive_name
	sudo mount /dev/mapper/$luksdrive_name /mnt/$luksdrive_name
}

# umount luks drive
function luks_umount()
{
	# get name and path
	luksdrive_name=$1	
	# umount and close drive
	sudo umount /mnt/$luksdrive_name
	sudo cryptsetup luksClose $luksdrive_name
	
}

# read cache file
function luksdrives_read_cache()
{
	# if cache file exists
	if [ -e $LUKSDRIVES_CACHE ]; then
		# for each line
		for line in `cat $LUKSDRIVES_CACHE`; do
			# get name and path of luks drive
			luksdrive_name=${line%:*}
			luksdrive_path=${line##*:}
			# add it to completions lists
			luksdrives_entries+=($luksdrive_name)
			luksdrives[$luksdrive_name]=$luksdrive_path
			luksdrives_completions+=($luksdrive_name:$luksdrives[$luksdrive_name])
		done
	fi
}
