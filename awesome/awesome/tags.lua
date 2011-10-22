-- File: tags.lua
-- Project: scyn-conf/conf/awesome
-- Brief: Tags definition for awesome configuration
-- Author: Scyn - Remi <remi.chaintron@gmail.com>
--

require("variables")

-- Tags definitions
shifty.config.tags =
{
	["[1. www]"] =
	{
		layout = max,
		position = 1,
		nopopup = true,
		exclusive = false,
		spawn = browser
	},
	["[2. code]"] =
	{
		layout = max,
		position = 2,
		nopopup = true,
		exclusive = false,
		spawn = "gvim --servername 1"
	},
	["[3. sh]"] =
	{
		layout=tile,
		position = 3,
		spawn=terminal
	},
	["[4. doc]"] =
	{
		layout=tile,
		position = 4
	},
	["[default]"] =
	{
		layout=floating,
		position = 10,
		init = true,
		spawn=terminal
	}
}

-- Applications dynamic tagging
shifty.config.apps =
{

	{
		match = {"Firefox", "Iceweasel", "chromium"},
		tag = "[1. www]",
		opacity = 1.0
	},
	{
		match = {"Evince", "evince"},
		tag = "[4. doc]",
		opacity = 1.0
	},
	{
		match = {"Gvim", "gvim"},
		tag = "[2. code]",
		opacity = 0.95
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

