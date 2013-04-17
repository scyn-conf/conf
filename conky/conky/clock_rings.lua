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
function rgb_to_r_g_b(color, alpha)
	return ((color / 0x10000) % 0x100) / 255., ((color / 0x100) % 0x100) / 255., (color % 0x100) / 255., alpha
end
-- }}}
-- {{{ deg2rad
function deg2rad(angle)
	return angle * (2 * math.pi / 360) - math.pi / 2
end
-- }}}
-- {{{ draw_rings
function draw_ring(cairo, t, pt)
	pt, t = pt["transformation"] (pt, t)
	-- ring informations
	local x = pt['x']
	local y = pt['y']
	local radius = pt['radius']
	local thickness = pt['thickness']
	local start_angle = pt['start_angle']
	local end_angle = pt['end_angle']
	local max_angle = pt['max_angle']
	local split_size = pt['split']
	local scale = pt['scale']
	-- colors
	local bg_color = pt['bg_color']
	local bg_alpha = pt['bg_alpha']
	local fg_color = pt['fg_color']
	local fg_alpha = pt['fg_alpha']
	-- calculate start and max angles for background ring (radians)
	local start_angle_rad = deg2rad(start_angle)
	local max_angle_rad = deg2rad(max_angle)
	local end_angle_rad = deg2rad(end_angle)

	-- draw background ring
	cairo_arc(cairo, x, y, radius, start_angle_rad, max_angle_rad)
	cairo_set_source_rgba(cairo, rgb_to_r_g_b(bg_color, bg_alpha))
	cairo_set_line_width(cairo, thickness)
	cairo_stroke(cairo)

	-- if there are splits, draw each element separately
	if split_size > 0 then
		local it = -1 -- we want to draw the first element
		local arc_range = max_angle / scale
		-- define first element
		element_start_angle = start_angle - arc_range / 2 + split_size
		element_end_angle = arc_range / 2 - split_size
		-- for each element
		while it < end_angle * scale / max_angle do
			-- get radial angles
			element_start_angle_rad = element_start_angle * (2 * math.pi / 360) - math.pi / 2
			element_end_angle_rad = element_end_angle * (2 * math.pi / 360) - math.pi / 2
			-- actual drawing
			cairo_arc(cairo, x, y, radius, element_start_angle_rad, element_end_angle_rad)
			cairo_set_source_rgba(cairo, rgb_to_r_g_b(fg_color, fg_alpha))
			cairo_stroke(cairo)
			-- incairoement
			element_end_angle = element_end_angle + max_angle / scale
			element_start_angle = element_start_angle + max_angle / scale
			it = it + 1
		end
	else -- else draw the ring
		cairo_arc(cairo, x, y, radius, start_angle_rad, end_angle_rad)
		cairo_set_source_rgba(cairo, rgb_to_r_g_b(fg_color, fg_alpha))
		cairo_stroke(cairo)
	end
end
-- }}}
-- {{{ init_vars
function init_vars ()
	seconds_cx = 1 * conky_window.width / 2 - 20
	seconds_cy = 1 * conky_window.height / 2 
	seconds_radius = 190

	minutes_cx = 1 * conky_window.width / 2 - 20
	minutes_cy = 1 * conky_window.height / 2 
	minutes_radius = 175

	hours_cx = 1 * conky_window.width / 2 - 20
	hours_cy = 1 * conky_window.height / 2 
	hours_radius = 160

	mark_cx = 1 * conky_window.width / 2 - 20
	mark_cy = 1 * conky_window.height / 2 
	mark_radius = 160

	out_cx = 1 * conky_window.width / 2 - 20
	out_cx = 1 * conky_window.height / 2 
	out_radius = 210

	mem_cx = 1 * conky_window.width / 2 - 20
	mem_cy = 580 * conky_window.height / 1024
	mem_radius = 42

	cpu_cx = 1 * conky_window.width / 2 - 20
	cpu_cy = 580 * conky_window.height / 1024
	cpu_radius = 35


	return {

--		{ -- hours mark
--			name = 'time',
--			arg = '%H',
--			max_angle = 360,
--			bg_color = 0xffffff,
--			bg_alpha = 0.2,
--			fg_color = 0xffffff,
--			fg_alpha = 0.5,
--			split = 14.7,
--			scale = 12,
--			x = mark_cx,
--			y = mark_cy,
--			radius = mark_radius,
--			thickness = 65,
--			start_angle = 0,
--			end_angle = 360,
--			transformation = function (self, value)
--				angle = 12 * self["max_angle"] / self["scale"]
--				self["start_angle"] = 0
--				self["end_angle"] = angle
--				return self, 1
--			end
--		},
--
--		{ -- memperc
--			name = 'memperc',
--			arg = '',
--			max_angle = 360,
--			bg_color = 0xffffff,
--			bg_alpha = 0.2,
--			fg_color = 0x00bfff,
--			fg_alpha = 1,
--			split = 0,
--			scale = 100,
--			x = mem_cx,
--			y = mem_cy,
--			radius = mem_radius,
--			thickness = 7,
--			start_angle = 0,
--			end_angle = 360,
--			transformation = function (self, value)
--				angle = value * 3.6
--				self["start_angle"] = 0
--				self["end_angle"] = angle
--				return self, 1
--			end
--		},
--
--		{ -- cpu 
--			name = 'cpu',
--			arg = '',
--			max_angle = 360,
--			bg_color = 0xffffff,
--			bg_alpha = 0.2,
--			fg_color = 0xa6e22e,
--			fg_alpha = 1,
--			split = 0,
--			scale = 100,
--			x = cpu_cx,
--			y = cpu_cy,
--			radius = cpu_radius,
--			thickness = 5,
--			start_angle = 0,
--			end_angle = 360,
--			transformation = function (self, value)
--				angle = value * 3.6
--				self["start_angle"] = 0
--				self["end_angle"] = angle
--				return self, 1
--			end
--		},

--		{ -- minutes mark
--			name = 'time',
--			arg = '%H',
--			max_angle = 360,
--			bg_color = 0xffffff,
--			bg_alpha = 0.0,
--			fg_color = 0xffffff,
--			fg_alpha = 0.1,
--			split = 2.5,
--			scale = 60,
--			x = mark_cx,
--			y = mark_cy,
--			radius = mark_radius - 25,
--			thickness = 10,
--			start_angle = 0,
--			end_angle = 360,
--			transformation = function (self, value)
--				angle = 60 * self["max_angle"] / self["scale"]
--				self["start_angle"] = 0
--				self["end_angle"] = angle
--				return self, 1
--			end
--		},
--
		{ -- seconds progress
			name = 'time',
			arg = '%S',
			max_angle = 360,
			bg_color = 0xffffff,
			bg_alpha = 0.0,
			fg_color = 0x00bfff,
			fg_alpha = 1,
			split = 0,
			scale = 60,
			x = seconds_cx,
			y = seconds_cy,
			radius = seconds_radius,
			thickness = 7,
			start_angle = 0,
			end_angle = 360,
			transformation = function (self, value)
					
				angle = value * self["max_angle"] / self["scale"]
				self["start_angle"] = 0
				self["end_angle"] = angle

				return self, 1
			end

		},

		{ -- seconds progress
			name = 'time',
			arg = '%S',
			max_angle = 360,
			bg_color = 0xffffff,
			bg_alpha = 0,
			fg_color = 0x00bfff,
			fg_alpha = 1,
			split = 0,
			scale = 60,
			x = mark_cx,
			y = mark_cy,
			radius = mark_radius - 25,
			thickness = 10,
			start_angle = 0,
			end_angle = 360,
			transformation = function (self, value)
				angle = value * self["max_angle"] / self["scale"]
				self["start_angle"] = angle - 0.4
				self["end_angle"] = angle + 0.4
				return self, 1
			end
		},

		{ -- minutes progress
			name = 'time',
			arg = '%M',
			max_angle = 360,
			bg_color = 0xffffff,
			bg_alpha= 0.0,
			fg_color = 0xa6e22e,
			fg_alpha = 1,
			split = 0,
			scale = 60,
			x = minutes_cx,
			y = minutes_cy,
			radius = minutes_radius,
			thickness = 12,
			start_angle = 0,
			end_angle = 360,
			transformation = function (self, value)
				angle = value * self["max_angle"] / self["scale"]
				self["start_angle"] = 0
				self["end_angle"] = angle
				return self, 1
			end
		},

		{ -- minutes progress
			name = 'time',
			arg = '%M',
			max_angle = 360,
			bg_color = 0xffffff,
			bg_alpha= 0,
			fg_color = 0xa6e22e,
			fg_alpha = 1,
			split = 0,
			scale = 60,
			x = mark_cx,
			y = mark_cy,
			radius = mark_radius - 25,
			thickness = 10,
			start_angle = 0,
			end_angle = 360,
			transformation = function (self, value)
				angle = value * self["max_angle"] / self["scale"]
				self["start_angle"] = angle - 0.4
				self["end_angle"] = angle + 0.4
				return self, 1
			end
		},

		{ -- hours progress
			name = 'time',
			arg = '%H',
			max_angle = 360,
			bg_color = 0xffffff,
			bg_alpha = 0,
			fg_color = 0xf6c84c,
			fg_alpha = 1,
			split =	0,
			scale =	12,
			x = hours_cx,
			y = hours_cy,
			radius = hours_radius,
			thickness = 10,
			start_angle = 0,
			end_angle = 360,
			transformation = function (self, value)
				if value < 12 then
					angle = value * self["max_angle"] / self["scale"]
				else
					angle = (value - 12) * self["max_angle"] / self["scale"]
				end
				self["start_angle"] = 0
				self["end_angle"] = angle
				return self, 1
			end
		},

		{ -- hours progress
			name = 'time',
			arg = '%H',
			max_angle = 360,
			bg_color = 0xffffff,
			bg_alpha = 0,
			fg_color = 0xf6c84c,
			fg_alpha = 1,
			split = 0,
			scale = 12,
			x = mark_cx,
			y = mark_cy,
			radius = mark_radius - 25,
			thickness = 10,
			start_angle = 0,
			end_angle = 360,
			transformation = function (self, value)
				if value < 12 then
					angle = value * self["max_angle"] / self["scale"]
				else
					angle = (value - 12) * self["max_angle"] / self["scale"]
				end
				self["start_angle"] = angle - 0.4
				self["end_angle"] = angle + 0.4
				return self, 1
			end
		}


--		{ -- outer ring
--			name = 'time',
--			arg = '',
--			max_angle = 360,
--			bg_color = 0xffffff,
--			bg_alpha = 0,
--			fg_color = 0xffffff,
--			fg_alpha = 1,
--			split = 10,
--			scale = 1,
--			x = hours_cx,
--			y = hours_cy,
--			radius = out_radius,
--			thickness = 7,
--			start_angle = 90,
--			end_angle = 270,
--			transformation = function (self, value)
--				self["start_angle"] = 180
--				self["end_angle"] = 360
--				return self, 1
--			end
--		}


	}
end

-- }}}
-- {{{ conky_ring_stats
function conky_ring_stats()
	local function setup_rings(cairo, pt)
		local str = ''
		local value = 0

		if pt['arg'] == nil then
			str = string.format('${%s}', pt['name'])
		else
			str = string.format('${%s %s}', pt['name'], pt['arg'])
		end
		str = conky_parse(str)

		value = tonumber(str)
--		pct = value/pt['max']

		draw_ring(cairo, value, pt)
	end

	if conky_window==nil then return end
	settings_table = init_vars ()
	local cairo_surface = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
	local cairo = cairo_create(cairo_surface)

	local updates = conky_parse('${updates}')
	update_num = tonumber(updates)

	if update_num>1 then
		for i in pairs(settings_table) do
			setup_rings(cairo, settings_table[i])
		end
	end
	cairo_surface_destroy(cairo_surface)
end
--- }}}
