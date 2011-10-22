-- File: bindings.lua
-- Project: scyn-conf/conf/awesome
-- Brief: Bindings definition for awesome configuration
-- Author: Scyn - Remi <remi.chaintron@gmail.com>
--

require("variables")

-- {{{ Mouse Bindings
root.buttons(awful.util.table.join(
awful.button({ }, 3, function() mymainmenu:toggle() end),
awful.button({ }, 4, awful.tag.viewnext),
awful.button({ }, 5, awful.tag.viewprev)
))

clientbuttons = awful.util.table.join(
awful.button({ }, 1, function(c) client.focus = c; c:raise() end),
awful.button({ modkey }, 1, awful.mouse.client.move),
awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- }}}
-- {{{ Key bindings
globalkeys = awful.util.table.join(
--	{{{ Motions
-- Change tags
awful.key({modkey,		}, "Left",	awful.tag.viewprev),
awful.key({modkey,		}, "Right",	awful.tag.viewnext),
-- Change client
awful.key({modkey,		}, "j",		function()
	awful.client.focus.byidx(1)
	if client.focus then
		client.focus:raise()
	end
end),
awful.key({modkey,		}, "k",		function()
	awful.client.focus.byidx(-1)
	if client.focus then
		client.focus:raise()
	end
end),
-- Move tags
awful.key({modkey, "Shift"	}, "Left",	shifty.shift_prev),
awful.key({modkey, "Shift"   	}, "Right",  	shifty.shift_next),
-- Swap clients
awful.key({modkey, "Shift"	}, "j",		function() awful.client.swap.byidx( 1) end),
awful.key({modkey, "Shift"   	}, "k", 	function() awful.client.swap.byidx(-1) end),
-- Resize tags
awful.key({modkey,		}, "l",		function() awful.tag.incmwfact( 0.05)    end),
awful.key({modkey,           	}, "h",     	function() awful.tag.incmwfact(-0.05)    end),


--	}}}
--	{{{ Tags bindings (shifty)
-- Add tag
awful.key({modkey,		}, "t",		shifty.add),
-- Delete tag
awful.key({modkey, "Shift"	}, "d",		shifty.del),
-- Rename tag
awful.key({modkey, "Shift"	}, "r",		shifty.rename),
-- Change layout
awful.key({modkey,		}, "Return",	function() awful.layout.inc(layouts,  1) end),
awful.key({modkey, "Shift"   	}, "Return", 	function() awful.layout.inc(layouts, -1) end),

--	}}}
--	{{{ Commands bindings
-- Spawn menu
awful.key({modkey,		}, "w",		function() mymainmenu:toggle() end),
-- Spawn terminal
awful.key({modkey,		}, "x",		function() awful.util.spawn(terminal) end),
-- Spawn launcher
--awful.key({modkey,		}, "r",		function() awful.util.spawn("gmrun") end),
awful.key({modkey,		}, "r",		function() teardrop(terminal_launcher, "bottom", "left", 0.6, 0.04) end),
-- Spawn teardrop terminal
awful.key({modkey		}, "space",	function() teardrop(terminal_td, "center", "center", 0.8, 0.7) end),
-- Spawn command prompt in wibox
awful.key({modkey		}, "BackSpace",	function() mypromptbox[mouse.screen]:run() end)

--	}}}
)


clientkeys = awful.util.table.join(
--	{{{ Client bindings
-- Make client appear on all screens
awful.key({modkey,		}, "s",		function(c) c.sticky = not c.sticky end),
-- Fullscreen
awful.key({modkey,		}, "f",		function(c) c.fullscreen = not c.fullscreen end),
-- Kill client
awful.key({modkey		}, "c",		function(c) c:kill() end),
-- Toogle floating layout
awful.key({modkey, "Control"	}, "space",	awful.client.floating.toggle),
-- Toogle maximization of client
awful.key({modkey,		}, "m",		function(c)
	c.maximized_horizontal = not c.maximized_horizontal
	c.maximized_vertical   = not c.maximized_vertical
end),
-- Increase/Decrease opacity
awful.key({modkey,		}, "o",		function(c)
	if c.opacity < 0.95 then
		c.opacity = c.opacity + 0.05
	else
		c.opacity = 1.0 
	end
end),
awful.key({modkey, "Shift"	}, "o",		function(c)
	if c.opacity > 0.05 then
		c.opacity = c.opacity - 0.05
	else
		c.opacity = 0.0
	end
end)
-- }}}
)

-- Key loop
for i = 1, (shifty.config.maxtags or 9 ) do
	table.foreach(awful.key({modkey}, i, function() local t = awful.tag.viewonly(shifty.getpos(i)) end),
				function(_, k) table.insert(globalkeys, k) end)
	table.foreach(awful.key({modkey, "Control"}, i,	function() local t = shifty.getpos(i); t.selected = not t.selected end),
				function(_, k) table.insert(globalkeys, k) end)
	table.foreach(awful.key({modkey, "Control", "Shift"}, i, function() if client.focus then awful.client.toggletag(shifty.getpos(i)) end end),
				function(_, k) table.insert(globalkeys, k) end)
	-- move clients to other tags
	table.foreach(awful.key({modkey, "Shift" }, i, function()
		if client.focus then
			local c = client.focus
			slave = not ( client.focus == awful.client.getmaster(mouse.screen))
			t = shifty.getpos(i)
			awful.client.movetotag(t)
			awful.tag.viewonly(t)
			if slave then awful.client.setslave(c) end
		end end),
		function(_, k) table.insert(globalkeys, k) end)
end

-- Set keys
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys
shifty.taglist = mytaglist
shifty.init()

-- }}}

