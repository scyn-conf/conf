function tag_move(t, scr)
    local ts = t or awful.tag.selected()
    local screen_target = scr or awful.util.cycle(screen.count(), ts.screen + 1)

    shifty.set(ts, {screen = screen_target})
end

function tag_to_screen(t, scr)
    -- {{{
    local ts = t or awful.tag.selected()
    local screen_origin = ts.screen
    local screen_target = scr or awful.util.cycle(screen.count(), ts.screen + 1)

    awful.tag.history.restore(ts.screen,1)
    tag_move(ts, screen_target)

    -- never waste a screen
    if #(screen[screen_origin]:tags()) == 0 then
        for _, tag in pairs(screen[screen_target]:tags()) do
            if not tag.selected then
                tag_move(tag, screen_origin)
                tag.selected = true
                break
            end
        end
    end

    awful.tag.viewonly(ts)
    mouse.screen = ts.screen
    if #ts:clients() > 0 then
        local c = ts:clients()[1]
        client.focus = c
    end

end

function goto_tag(id)
	local ts = awful.getpos(id)

	awful.screen.focus(ts.screen)
	awful.tag.viewonly(ts)
end
--}}}
