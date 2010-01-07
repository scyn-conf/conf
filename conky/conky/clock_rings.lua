--[[
Ring Meters by londonali1010 (2009)

This script draws percentage meters as rings. It is fully customisable; all options are described in the script.

IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement on line 145 uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num>5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num>3; conversely if you update Conky every 0.5s, you should use update_num>10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
	lua_load ~/scripts/rings-v1.2.lua
	lua_draw_hook_pre ring_stats
	
Changelog:
+ v1.2 -- Added option for the ending angle of the rings (07.10.9009)
+ v1.1 -- Added options for the starting angle of the rings, and added the "max" variable, to allow for variables that output a numerical value rather than a percentage (29.09.2009)
+ v1.0 -- Original release (28.09.2009)
]]



require 'cairo'
-- {{{ rgb_to_r_g_b
function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
-- }}}
-- {{{ draw_rings
function draw_ring(cr,t,pt)
	pt, t=pt["transformation"] (pt, t)
	local w,h=conky_window.width,conky_window.height
	local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=t*(angle_f-angle_0)

	-- Draw background ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)
	
	-- Draw indicator ring

	cairo_arc(cr,conky_window.width / 2, conky_window.height / 2 - conky_window.height / 20, ring_r,angle_0,angle_0+t_arc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)		
end
-- }}}
-- {{{ init_vars
function init_vars ()
	seconds_cx = conky_window.width / 2
	seconds_cy = conky_window.height / 2
	minutes_cx = conky_window.width / 2
	minutes_cy = conky_window.height / 2
	hours_cx = conky_window.width / 2
	hours_cy = conky_window.height / 2

	seconds_radius=140
	minutes_radius=90
	hours_radius=50
	center_radius=20
	return {
--		{ -- center
--			name='time',
--			arg='%S',
--			max=1,
--			bg_colour=0xffffff,
--			bg_alpha=0.0,
--			fg_colour=0xffffff,
--			fg_alpha=1.0,
--			x=seconds_cx,
--			y=seconds_cy,
--			radius=center_radius - 3,
--			thickness=2,
--			start_angle=0,
--			end_angle=360,
--			transformation = function (self, value)
--				return self, 1
--			end
--
--		},
		{ -- seconds hand 1
			name='time',
			arg='%S',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.0,
			fg_colour=0xffffff,
			fg_alpha=1.0,
			x=seconds_cx,
			y=seconds_cy,
			radius=seconds_radius - (seconds_radius - minutes_radius) / 2 + 2,
			thickness=seconds_radius-minutes_radius,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				v = value * 6
				self["start_angle"] = v + 2
				self["end_angle"] = v + 4
				return self, 1
			end
		},
		{ -- seconds hand 2
			name='time',
			arg='%S',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.0,
			fg_colour=0xffffff,
			fg_alpha=1.0,
			x=seconds_cx,
			y=seconds_cy,
			radius=seconds_radius - (seconds_radius - minutes_radius) / 2 + 2,
			thickness=seconds_radius-minutes_radius,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				v = value * 6
				self["start_angle"] = v - 3
				self["end_angle"] = v -1
				return self, 1
			end
		},
		{ -- seconds circle 1
			name='time',
			arg='%S',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.0,
			fg_colour=0xffffff,
			fg_alpha=0.9,
			x=seconds_cx,
			y=seconds_cy,
			radius=seconds_radius,
			thickness=4,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				value = value * 6
				self["start_angle"] = value + 3
				self["end_angle"] = value + 120
				return self, 1
			end
		},
		{ -- seconds circle 2
			name='time',
			arg='%S',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.0,
			fg_colour=0xffffff,
			fg_alpha=0.9,
			x=seconds_cx,
			y=seconds_cy,
			radius=seconds_radius,
			thickness=4,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				value = value * 6
				self["start_angle"] = value - 120
				self["end_angle"] = value - 3
				return self, 1
			end
		},
		{ -- minutes hand 1
			name='time',
			arg='%M',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.0,
			fg_colour=0xffffff,
			fg_alpha=1.0,
			x=minutes_cx,
			y=minutes_cy,
			radius=minutes_radius - (minutes_radius - hours_radius) / 2 + 2,
			thickness=minutes_radius - hours_radius,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				value = value * 6
				self["start_angle"] = value + 2
				self["end_angle"] = value + 4
				return self, 1
			end
		},
		{ -- minutes hand 2
			name='time',
			arg='%M',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.0,
			fg_colour=0xffffff,
			fg_alpha=1.0,
			x=minutes_cx,
			y=minutes_cy,
			radius=minutes_radius - (minutes_radius - hours_radius) / 2 + 2,
			thickness=minutes_radius - hours_radius,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				value = value * 6
				self["start_angle"] = value -3
				self["end_angle"] = value - 1
				return self, 1
			end
		},
		{ -- minutes circle 1
			name='time',
			arg='%M',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.0,
			fg_colour=0xffffff,
			fg_alpha=0.9,
			x=minutes_cx,
			y=minutes_cy,
			radius=minutes_radius,
			thickness=4,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				value = value * 6
				self["start_angle"] = value + 3
				self["end_angle"] = value + 120
				return self, 1
			end
		},
		{ -- minutes circle 2
			name='time',
			arg='%M',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.0,
			fg_colour=0xffffff,
			fg_alpha=0.9,
			x=minutes_cx,
			y=minutes_cy,
			radius=minutes_radius,
			thickness=4,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				value = value * 6
				self["start_angle"] = value - 120
				self["end_angle"] = value - 3
				return self, 1
			end
		},
		{ -- hours hand 1
			name='time',
			arg='%I',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.0,
			fg_colour=0xffffff,
			fg_alpha=1.0,
			x=hours_cx,
			y=hours_cy,
			radius=hours_radius - (hours_radius - center_radius) / 2 + 2,
			thickness=hours_radius - center_radius,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				self["start_angle"] = value * 30 + 3
				self["end_angle"] = value * 30 + 6
				return self, 1
			end
		},
		{ -- hours hand 2
			name='time',
			arg='%I',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.0,
			fg_colour=0xffffff,
			fg_alpha=1.0,
			x=hours_cx,
			y=hours_cy,
			radius=hours_radius - (hours_radius - center_radius) / 2 + 2,
			thickness=hours_radius - center_radius,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				self["start_angle"] = value * 30 - 5
				self["end_angle"] = value * 30 - 2
				return self, 1
			end
		},
		{ -- hours circle 1
			name='time',
			arg='%I',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.0,
			fg_colour=0xffffff,
			fg_alpha=0.9,
			x=hours_cx,
			y=hours_cy,
			radius=hours_radius,
			thickness=4,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				self["start_angle"] = value * 30 + 6
				self["end_angle"] = value * 30 + 120
				return self, 1
			end
		},
		{ -- hours circle 2
			name='time',
			arg='%I',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.0,
			fg_colour=0xffffff,
			fg_alpha=0.9,
			x=hours_cx,
			y=hours_cy,
			radius=hours_radius,
			thickness=4,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				self["start_angle"] = value * 30 - 120
				self["end_angle"] = value * 30 - 3
				return self, 1
			end
		}
	}
end
-- }}}
-- {{{ conky_ring_stats
function conky_ring_stats()
	local function setup_rings(cr,pt)
		local str=''
		local value=0
		
		str=string.format('${%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)
		
		value=tonumber(str)
		pct=value/pt['max']
		
		draw_ring(cr,value,pt)
	end

	if conky_window==nil then return end
	settings_table = init_vars ()
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
	local cr=cairo_create(cs)	
	
	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)
	
	if update_num>5 then
		for i in pairs(settings_table) do
			setup_rings(cr,settings_table[i])
		end
	end
end
--- }}}
