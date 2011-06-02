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

	cairo_arc(cr, xc, yc, ring_r,angle_0,angle_0+t_arc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)
end
-- }}}
-- {{{ init_vars
function init_vars ()
	seconds_cx = 11 * conky_window.width / 12
	seconds_cy = 3 * conky_window.height / 20
	seconds_radius=100

	minutes_cx = 11 * conky_window.width / 12
	minutes_cy = 3 * conky_window.height / 20
	minutes_radius=90

	hours_cx = 11 * conky_window.width / 12
	hours_cy = 3 * conky_window.height / 20
	hours_radius=80

	cpu_cx = 11 * conky_window.width / 12 - 170
	cpu_cy = 3 * conky_window.height / 20 + 20
	cpu_radius = 35

	ram_cx = 11 * conky_window.width / 12 - 150
	ram_cy = 3 * conky_window.height / 20 + 85
	ram_radius=30

	swap_cx = 11 * conky_window.width / 12 - 105
	swap_cy = 3 * conky_window.height / 20 + 135
	swap_radius=30

	fs_cx = 11 * conky_window.width / 12 - 40
	fs_cy = 3 * conky_window.height / 20 + 160
	fs_radius=30

	entropy_cx = 11 * conky_window.width / 12 + 30
	entropy_cy = 3 * conky_window.height / 20 + 170
	entropy_radius=30


	return {
		{ -- seconds progress
			name='time',
			arg='%S',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xeee8aa,
			fg_alpha=0.5,
			x=seconds_cx,
			y=seconds_cy,
			radius=seconds_radius,
			thickness=5,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				value = value * 6
				self["start_angle"] = 0
				self["end_angle"] = value
				return self, 1
			end
		},

		{ -- minutes progress
			name='time',
			arg='%M',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0x96cbfe,
			fg_alpha=0.5,
			x=minutes_cx,
			y=minutes_cy,
			radius=minutes_radius,
			thickness=5,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				value = value * 6
				self["start_angle"] = 0
				self["end_angle"] = value
				return self, 1
			end
		},

		{ -- hours progress
			name='time',
			arg='%H',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0x9acd32,
			fg_alpha=0.5,
			x=hours_cx,
			y=hours_cy,
			radius=hours_radius,
			thickness=5,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				if value < 12 then
					value = value * 30
				else
					value = (value - 12) * 30
				end
				self["start_angle"] = 0
				self["end_angle"] = value
				return self, 1
			end
		},

 --		{ -- swap
 --			name='swapperc',
 --			arg='%H',
 --			max=1,
 --			bg_colour=0xffffff,
 --			bg_alpha=0.5,
 --			fg_colour=0xffffff,
 --			fg_alpha=0.5,
 --			x=swap_cx,
 --			y=swap_cy,
 --			radius=swap_radius,
 --			thickness=2,
 --			start_angle=0,
 --			end_angle=360,
 --			transformation = function (self, value)
 --				value = value * 3.6
 --				self["start_angle"] = 0
 --				self["end_angle"] = value
 --				return self, 1
 --			end
 --		},

		{ -- ram
			name='memperc',
			arg='%H',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x=ram_cx,
			y=ram_cy,
			radius=ram_radius,
			thickness=2,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				value = value * 3.6
				self["start_angle"] = 0
				self["end_angle"] = value
				return self, 1
			end
		},

		{ -- entropy
			name='entropy_perc',
			arg=nil,
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x=entropy_cx,
			y=entropy_cy,
			radius=entropy_radius,
			thickness=2,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				value = value * 3.6
				self["start_angle"] = 0
				self["end_angle"] = value
				return self, 1
			end
		},

		{ -- cpu0
			name='cpu',
			arg='cpu0',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=1,
			x=cpu_cx,
			y=cpu_cy,
			radius=cpu_radius + 2,
			thickness=2,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				value = value * 3.6
				self["start_angle"] = 0
				self["end_angle"] = value
				return self, 1
			end
		},

		{ -- cpu1
			name='cpu',
			arg='cpu1',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0x0050aa,
			fg_alpha=1,
			x=cpu_cx,
			y=cpu_cy,
			radius=cpu_radius - 2,
			thickness=1,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				color = 0x0050aa
				if value <= 5 then
					color = 0xadbed1
				elseif value > 5 and value <= 20 then
					color = 0xace1af
				elseif value > 20 and value <= 50 then
					color = 0xfcda98
				elseif value > 50 and value <= 75 then
					color = 0xf3ba5e
				elseif value > 75 and value <= 100 then
					color = 0xf3785e
				end
				value = value * 3.6
				self["start_angle"] = 0
				self["end_angle"] = value
				self["fg_colour"] = color
				return self, 1
			end
		},


		{ -- cpu2
			name='cpu',
			arg='cpu2',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0x0050aa,
			fg_alpha=1,
			x=cpu_cx,
			y=cpu_cy,
			radius=cpu_radius - 4,
			thickness=1,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				color = 0x0050aa
				if value <= 5 then
					color = 0xadbed1
				elseif value > 5 and value <= 20 then
					color = 0xace1af
				elseif value > 20 and value <= 50 then
					color = 0xfcda98
				elseif value > 50 and value <= 75 then
					color = 0xf3ba5e
				elseif value > 75 and value <= 100 then
					color = 0xf3785e
				end
				value = value * 3.6
				self["start_angle"] = 0
				self["end_angle"] = value
				self["fg_colour"] = color
				return self, 1
			end
		},


		{ -- cpu3
			name='cpu',
			arg='cpu3',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0x0050aa,
			fg_alpha=1,
			x=cpu_cx,
			y=cpu_cy,
			radius=cpu_radius - 6,
			thickness=1,
			start_angle=5,
			end_angle=360,
			transformation = function (self, value)
				color = 0x0050aa
				if value <= 5 then
					color = 0xadbed1
				elseif value > 5 and value <= 20 then
					color = 0xace1af
				elseif value > 20 and value <= 50 then
					color = 0xfcda98
				elseif value > 50 and value <= 75 then
					color = 0xf3ba5e
				elseif value > 75 and value <= 100 then
					color = 0xf3785e
				end
				value = value * 3.6
				self["start_angle"] = 0
				self["end_angle"] = value
				self["fg_colour"] = color
				return self, 1
			end
		},


		{ -- cpu4
			name='cpu',
			arg='cpu4',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0x0050aa,
			fg_alpha=1,
			x=cpu_cx,
			y=cpu_cy,
			radius=cpu_radius - 8,
			thickness=1,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				color = 0x0050aa
				if value <= 5 then
					color = 0xadbed1
				elseif value > 5 and value <= 20 then
					color = 0xace1af
				elseif value > 20 and value <= 50 then
					color = 0xfcda98
				elseif value > 50 and value <= 75 then
					color = 0xf3ba5e
				elseif value > 75 and value <= 100 then
					color = 0xf3785e
				end
				value = value * 3.6
				self["start_angle"] = 0
				self["end_angle"] = value
				self["fg_colour"] = color
				return self, 1
			end
		},

		{ -- fs
			name='fs_used_perc',
			arg='/',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x=fs_cx,
			y=fs_cy,
			radius=fs_radius,
			thickness=2,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				value = value * 3.6
				self["start_angle"] = 0
				self["end_angle"] = value
				return self, 1
			end
		},

--		{ -- swap rule
--			name='swapperc',
--			arg='%H',
--			max=1,
--			bg_colour=0xffffff,
--			bg_alpha=0.5,
--			fg_colour=0xffffff,
--			fg_alpha=0.5,
--			x=swap_cx,
--			y=swap_cy,
--			radius=swap_radius,
--			thickness=0.3,
--			start_angle=0,
--			end_angle=360,
--			transformation = function (self, value)
--				return self, 1
--			end
--		},

		{ -- ram rule
			name='memperc',
			arg='%H',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x=ram_cx,
			y=ram_cy,
			radius=ram_radius,
			thickness=0.3,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				return self, 1
			end
		},

		{ -- entropy rule
			name='entropy_perc',
			arg=nil,
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x=entropy_cx,
			y=entropy_cy,
			radius=entropy_radius,
			thickness=0.3,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				return self, 1
			end
		},

		{ -- cpu rule
			name='cpu',
			arg='cpu0',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x=cpu_cx,
			y=cpu_cy,
			radius=cpu_radius,
			thickness=0.3,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				return self, 1
			end
		},

		{ -- fs rule
			name='fs_used_perc',
			arg='/',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x=fs_cx,
			y=fs_cy,
			radius=fs_radius,
			thickness=0.3,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				return self, 1
			end
		},

		{ -- Watch outer shell
			name='time',
			arg='%H',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x=seconds_cx,
			y=seconds_cy,
			radius = seconds_radius + 10,
			thickness=0.5,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				return self, 1
			end

		},

		{ -- Watch outer shell
			name='time',
			arg='%H',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x=seconds_cx,
			y=seconds_cy,
			radius = seconds_radius + 7,
			thickness=1.5,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				return self, 1
			end

		},

		{ -- Watch inner shell
			name='time',
			arg='%H',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x= hours_cx,
			y= hours_cy,
			radius = hours_radius - 4,
			thickness=0.5,
			start_angle=0,
			end_angle=360,
			transformation = function (self, value)
				return self, 1
			end

		},

		{ -- decoration
			name='time',
			arg='%H',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x=hours_cx,
			y=hours_cy,
			radius=235,
			thickness=0.5,
			start_angle=90,
			end_angle=270,
			transformation = function (self, value)
				return self, 1
			end
		},

		{ -- decoration
			name='time',
			arg='%H',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x=hours_cx,
			y=hours_cy,
			radius=230,
			thickness=3,
			start_angle=290,
			end_angle=0,
			transformation = function (self, value)
				return self, 1
			end
		},

		{ -- decoration
			name='time',
			arg='%H',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x=hours_cx,
			y=hours_cy,
			radius=235,
			thickness=0.5,
			start_angle=290,
			end_angle=0,
			transformation = function (self, value)
				return self, 1
			end
		},

		{ -- decoration
			name='time',
			arg='%H',
			max=1,
			bg_colour=0xffffff,
			bg_alpha=0.5,
			fg_colour=0xffffff,
			fg_alpha=0.5,
			x=hours_cx,
			y=hours_cy,
			radius=230,
			thickness=3,
			start_angle=90,
			end_angle=270,
			transformation = function (self, value)
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

		if pt['arg'] == nil then
			str=string.format('${%s}',pt['name'])
		else
			str=string.format('${%s %s}',pt['name'],pt['arg'])
		end
		str=conky_parse(str)

		value=tonumber(str)
--		pct=value/pt['max']

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
