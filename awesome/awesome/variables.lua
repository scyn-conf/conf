-- File: variables.lua
-- Project: scyn-conf/conf/awesome
-- Brief: Variables definition for awesome configuration
-- Author: Scyn - Remi <remi.chaintron@gmail.com>
--

-- Themes define colours, icons, and wallpapers
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/scyn/theme.lua")

-- Variables
terminal	=	"/usr/bin/urxvt -pe tabbed"
terminal_td	=	"/usr/bin/urxvt -pe tabbed -name teardrop"
terminal_launcher =	"/usr/bin/urxvt -name launcher"
app_launcher	=	"gmrun"
browser		=	"chromium"
editor		=	os.getenv("EDITOR") or "editor"
editor_cmd	=	terminal .. " -e " .. editor

-- Default modkey.
modkey		=	"Mod4" -- Windows
modkey2		=	"Mod1" -- Alt

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	awful.layout.suit.floating
}
