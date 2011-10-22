-- File: menu.lua
-- Project: scyn-conf/conf/awesome
-- Brief: Menu definition for awesome configuration
-- Author: Scyn - Remi <remi.chaintron@gmail.com>
--

require("variables")

-- Create a laucher widget and a main menu
myawesomemenu =
{

	{ 
		"manual",
		terminal .. " -e man awesome"
	},
	{
		"restart",
		awesome.restart
	},
	{
		"quit",
		awesome.quit
	}
}

mymainmenu = awful.menu(
{
	items =
	{
		{
			"awesome",
			myawesomemenu,
			beautiful.awesome_icon
		}
	}
})

mylauncher = awful.widget.launcher(
{
	image = image(beautiful.awesome_icon),
	menu = mymainmenu
})




