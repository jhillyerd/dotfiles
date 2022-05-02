local awful = require("awful")
local beautiful = require("beautiful")
local lain = require("lain")
local wibox = require("wibox")

local markup = lain.util.markup;
local dpi = require("beautiful.xresources").apply_dpi
local theme = beautiful.get()

local function make_icon(char)
    return wibox.widget {
        font = theme.icon_font,
        markup = ' ' .. char .. ' ',
        forced_width = dpi(30),
        align = 'right',
        valign = 'center',
        widget = wibox.widget.textbox,
    }
end

-- Textclock
local clockicon = make_icon('')
os.setlocale(os.getenv("LANG")) -- to localize the clock
local mytextclock = wibox.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#ab7367", ">") .. markup("#de5e1e", " %H:%M %P "))
mytextclock.font = theme.font

-- CPU
local cpuicon = make_icon('')
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
    end
})

-- Coretemp
local tempicon = make_icon('')
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C "))
    end
})

-- Battery
local baticon = make_icon('')
local bat = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

        if bat_now.ac_status == 1 then
            perc = perc .. " plug"
        end

        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc .. " "))
    end
})

-- Volume
local volicon = make_icon('')
local volume = lain.widget.pulse({
    settings = function()
        local vlevel = volume_now.left .. "%"
        if volume_now.muted == "yes" then
            vlevel = vlevel .. " M"
        end

        widget:set_markup(markup.fontfg(theme.font, "#87af5f", vlevel))
    end
})

volume.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- left click
        awful.spawn("pavucontrol")
    end),
    awful.button({}, 3, function() -- right click
        os.execute(string.format("pactl set-sink-mute %s toggle", volume.device))
        volume.update()
    end),
    awful.button({}, 4, function() -- scroll up
        os.execute(string.format("pactl set-sink-volume %s +3%%", volume.device))
        volume.update()
    end),
    awful.button({}, 5, function() -- scroll down
        os.execute(string.format("pactl set-sink-volume %s -3%%", volume.device))
        volume.update()
    end)
))

-- Net
local netdownicon = make_icon('')
local netdowninfo = wibox.widget.textbox()
local netupicon = make_icon('')
local netupinfo = lain.widget.net({
    units = 1024^2, -- MB
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e54c62", net_now.sent .. "MiB "))
        netdowninfo:set_markup(markup.fontfg(theme.font, "#87af5f", net_now.received .. "MiB "))
        widget:set_forced_width(dpi(60))
        netdowninfo:set_forced_width(dpi(60))
    end
})

-- Mem
local memicon = make_icon('')
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.perc .. "% "))
    end
})

-- Create the wibox
local create_wibox = function(s)
  return awful.wibar {
    position = "top",
    screen = s,
    height = dpi(20),
    bg = theme.bg_normal,
    fg = theme.fg_normal,
    widget = wibox.widget {
      {
          s.mytaglist,
          s.mypromptbox,
          layout = wibox.layout.fixed.horizontal,
      },
      {
          s.mytasklist,
          width = 600,
          strategy = "max",
          layout = wibox.layout.constraint,
      },
      {
          wibox.widget.systray(),
          netdownicon,
          netdowninfo,
          netupicon,
          netupinfo.widget,
          memicon,
          mem.widget,
          cpuicon,
          cpu.widget,
          tempicon,
          temp.widget,
          baticon,
          bat.widget,
          volicon,
          volume.widget,
          clockicon,
          mytextclock,
          layout = wibox.layout.fixed.horizontal,
      },
      expand = "none",
      layout = wibox.layout.align.horizontal,
    },
  }
end

return create_wibox;
