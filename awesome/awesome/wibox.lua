-- File: wibox.lua
-- Project: scyn-conf/conf/awesome
-- Brief: Wibox definition for awesome configuration
-- Author: Scyn - Remi <remi.chaintron@gmail.com>
--
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
require("variables")
-- Systray widget
mysystray = widget({type = "systray"})
--
---- Variables
--mywibox		= {}
--mytaskbar	= {}
--mypromptbox	= {}
--mylayoutbox	= {}
--
---- Taglist
--mytaglist	= {}
--mytaglist.buttons = awful.util.table.join
--(
--awful.button({}, 1, awful.tag.viewonly),
--awful.button({modkey}, 1, awful.client.movetotag),
--awful.button({}, 3, awful.tag.viewtoggle),
--awful.button({modkey}, 3, awful.client.toggletag),
--awful.button({}, 4, awful.tag.viewnext),
--awful.button({}, 5, awful.tag.viewprev)
--)
--
---- Tasklist
--mytasklist	= {}
--mytasklist.buttons = awful.util.table.join
--(
---- Button 1
--awful.button({ }, 1, function (c)
--	if not c:isvisible() then
--		awful.tag.viewonly(c:tags()[1])
--	end
--	client.focus = c
--	c:raise()
--end),
--
---- Button 3
--awful.button({ }, 3, function ()
--	if instance then
--		instance:hide()
--		instance = nil
--	else
--		instance = awful.menu.clients({ width=250 })
--	end
--end),
--
---- Button 4
--awful.button({ }, 4, function ()
--	awful.client.focus.byidx(1)
--	if client.focus then client.focus:raise() end
--end),
--
---- Button 5
--awful.button({ }, 5, function ()
--	awful.client.focus.byidx(-1)
--	if client.focus then client.focus:raise() end
--end)
--)
--
---- Wibox creation
--for s = 1, screen.count() do
--	-- Create a promptbox for each screen
--	mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
--
--	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
--	-- We need one layoutbox per screen.
--	mylayoutbox[s] = awful.widget.layoutbox(s)
--	mylayoutbox[s]:buttons(awful.util.table.join
--	(
--	awful.button({}, 1, function () awful.layout.inc(layouts, 1) end),
--	awful.button({}, 3, function () awful.layout.inc(layouts, -1) end),
--	awful.button({}, 4, function () awful.layout.inc(layouts, 1) end),
--	awful.button({}, 5, function () awful.layout.inc(layouts, -1) end))
--	)
--
--	-- Create a taglist widget
--	mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
--
--	-- Create a tasklist widget
--	mytasklist[s] = awful.widget.tasklist
--	(
--	function(c)
--		return awful.widget.tasklist.label.currenttags(c, s)
--	end, 
--	mytasklist.buttons
--	)
--
--	-- Create the wibox
--	mywibox[s] = awful.wibox({position = "top", screen = s})
--	mywibox[s].widgets =
--	{
--		{
--			mylauncher,
--			mytaglist[s],
--			mytasklist[s],
--			mypromptbox[s],
--			mylayoutbox[s],
--			s == 1 and mysystray or nil,
--			layout = awful.widget.layout.horizontal.leftright
--		},
--		layout = awful.widget.layout.horizontal.leftright
--	}
--	mywibox[s].screen = s
--end
--
--	{{{2 Variables
mywibox = {}
mytaskbar = {}
mypromptbox = {}
mylayoutbox = {}

--	}}}
--	{{{2 Taglist
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )

--	}}}
--	{{{2 Tasklist
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

--	}}}
	{{{2 Wibox creation
for s = 1, screen.count() do

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)
    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "bottom", screen = s })
	-- Create the wibox
	mywibox[s] = awful.wibox({position = "top", screen = s})
	mywibox[s].widgets =
	{
		{
			mylauncher,
			mytaglist[s],
			mytasklist[s],
			mypromptbox[s],
--			mylayoutbox[s],
			layout = awful.widget.layout.horizontal.leftright
		},
		layout = awful.widget.layout.horizontal.leftright
	}
    mytaskbar[s] = awful.wibox({position = "top", screen = s})
    mytaskbar[s].widgets = {mylayoutbox[s], mytasklist[s], layout = awful.widget.layout.horizontal.rightleft}
    mywibox[s].screen = s
    mytaskbar[s].screen = s
end


