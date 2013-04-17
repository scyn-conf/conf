-- File: tags.lua
-- Project: scyn-conf/conf/awesome
-- Brief: Tags definition for awesome configuration
-- Author: Scyn - Remi <remi.chaintron@gmail.com>
--

require("variables")

-- Tags definitions
shifty.config.tags =
{
	[" www      "] =
	{
		layout = max,
		position = 1,
		nopopup = true,
		exclusive = false,
		bg_color = "#f11438cc",
		fg_color = "#ffffff",
		spawn = browser
	},
	[" code     "] =
	{
		layout = max,
		position = 2,
		nopopup = true,
		exclusive = false,
		bg_color = "#f49b00cc",
		fg_color = "#ffffff",
		spawn = "gvim --servername 1"
	},
	[" media    "] =
	{
		layout=tile,
		position = 3,
		bg_color = "#14eef1cc",
		fg_color = "#ffffff",
	},
	[" doc      "] =
	{
		layout=tile,
		bg_color = "#00bfffcc",
		fg_color = "#ffffff",
		position = 4
	},
	["  games   "] =
	{
		layout=tile,
		position = 5,
		bg_color = "#a6e22ecc",
		fg_color = "#ffffff",
		spawn = terminal .. " -e irssi"
	},
	[" skype    "] =
	{
		layout=tile,
		position = 6,
		bg_color = "#14eef1cc",
		fg_color = "#ffffff",
		spawn = "skype"
	},
	[" music    "] =
	{
		layout=tile,
		position = 7,
		bg_color = "#00bfffcc",
		fg_color = "#ffffff",
		spawn = "deadbeef"
	},

	[" default  "] =
	{
		layout=floating,
		position = 0,
		init = true,
		bg_color = "#a6e22ecc",
		fg_color = "#ffffff",
		spawn=terminal
	}
}

-- Applications dynamic tagging
shifty.config.apps =
{
	{
		match = {"Firefox", "Iceweasel", "chromium"},
		tag = " www      ",
		--opacity = 1.0
	},
	{
		match = {"Dustforce", "dustforce"},
		tag = " games    ",
		--opacity = 1.0
	},
	{
		match = {"VLC", "Vlc", "vlc"},
		tag = " media    ",
		opacity = 1.0,
	},
	{
		match = {"Transmission", "transmission"},
		tag = " media    ",
		--opacity = 1.0
	},
	{
		match = {"Spotify", "spotify"},
		tag = " media    ",
		--opacity = 1.0
	},
	{
		match = {"deadbeef"},
		tag = " music    ",
		--opacity = 0.9
	},
	{
		match = {"Evince", "evince", "libreoffice", "LibreOffice", "Libreoffice"},
		tag = " doc      ",
		--opacity = 1.0
	},
	{
		match = {"Pidgin", "pidgin"},
		tag = " im       ",
		--opacity = 1.0
	},
	{
		match = {"Gvim", "gvim"},
		tag = " code     ",
		--opacity = 0.95
	},
	{
		match = { "VirtualBox", "virtualbox" },
		tag = " vm       ",
		--opacity = 1.0
	},
	{
		match = {"URxvt", "urxvt", "rxvt-unicode"},
		--opacity = 0.90,
		honorsizehints = false
	},
	{
		match = { "Thunderbird", "thunderbird" },
		tag = " mail     ",
		--opacity = 1.0
	},
	{
		match = { "" },
		buttons =
		awful.util.table.join(awful.button({}, 1, function (c) client.focus = c; c:raise() end),
		awful.button({modkey}, 1, awful.mouse.client.move), awful.button({modkey}, 3, awful.mouse.client.resize),
		awful.button({modkey}, 8, awful.mouse.client.resize)
		)
	}
}


-- Tags default layout
shifty.config.defaults =
{
	layout = awful.layout.suit.tile,
	ncol = 1,
	mwfact = 0.50,
	floatBars=false,
}

