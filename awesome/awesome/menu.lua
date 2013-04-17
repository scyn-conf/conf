-- File: menu.lua
-- Project: scyn-conf/conf/awesome
-- Brief: Menu definition for awesome configuration
-- Author: Scyn - Remi <remi.chaintron@gmail.com>
--

require("variables")
applications_menu =
{
	--	{ "firefox", "firefox" },
	{ "chrome", "chromium-browser" },
	--	{ "thunderbird", "thunderbird" },
	{ "urxvt", "urxvt" },
	{ "gvim", "gvim --servername 1" },
	--	{ "deadbeef", "deadbeef" },
	{ "spotify", "spotify"},
	--	{ "virtualbox", "virtualbox" }
	{ "transmission", "transmission-gtk"},
	{ "", nil },
	{ "dustforce", "/usr/local/games/Dustforce/Dustforce.bin.x86_64"}
}

awesome_menu =
{
	{ "quit", awesome.quit },
	{ "restart", awesome.restart }
}

power_menu =
{
	{ "lock", "gnome-screensaver-command -l" },
	{ "logout", awesome.quit },
	{"", ""},
	{ "reboot", "sudo shutdown -r now" },
	{ "suspend", "sudo pm-suspend" },
	{ "hibernate", "sudo pm-hibernate" },
	{ "poweroff", "sudo shutdown -h now" }
}

audio_menu =
{
	{ "headphones", "/home/scyn/conf/scripts/audio_switch.sh 2"},
	{ "speakers", "/home/scyn/conf/scripts/audio_switch.sh 1"},
}

keyboard_menu =
{
	{ "us", "setxkbmap us"},
	{ "us_intl", "setxkbmap us_intl"},
	{ "fr", "setxkbmap fr"}
}

mount_menu =
{
	{ "usb", "mount /dev/sdd1 /media/usb/"},
	{ "android", nil },
}
system_menu = 
{
	{ "audio", audio_menu },
	{ "keyboard", keyboard_menu },
	{ "mount", mount_menu },
	{ "", nil },
	{ "awesome", awesome_menu },
	{ "power", power_menu}

}
mymainmenu = awful.menu({
	items =
	{
		{
			"apps",
			applications_menu
		},
		{
			"sys",
			system_menu,
		}
	},
	width=200,
	height=30
})

mylauncher = awful.widget.launcher(
{
	image = nil,
	menu = mymainmenu
})

