-- Standard awesome library
local gears = require('gears')
local awful = require('awful')

-- Wibox handling library
local wibox = require('wibox')

-- Lain widgets
-- local lain = require("lain")

-- Custom Local Library: Common Functional Decoration
local deco = {
  wallpaper = require('deco.wallpaper'),
  taglist = require('deco.taglist'),
  tasklist = require('deco.tasklist'),
}

local taglist_buttons = deco.taglist()
local tasklist_buttons = deco.tasklist()

-- local cpu_widget = require('awesome-wm-widgets.cpu-widget.cpu-widget')

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Create a promptbox for each screen
  -- s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))

  -- Create cpu widget
  -- local mycpu = cpu_widget({
  --   width = 120,
  --   step_width = 8,
  --   step_spacing = 2,
  --   color = '#ffffff',
  -- })

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
  })

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
  })

  -- df -h --output=avail /dev/nvme0n1p5 -- HOME
  -- df -h --output=avail /dev/nvme0n1p4 -- SYS
  -- local homedir = awful.widget.watch(
  --   'df -h --output=avail /home',
  --   30,
  --   function(widget, stdout)
  --     for line in stdout:gmatch('[^\r\n]+') do
  --       if line ~= 'Avail' then
  --         widget:set_text('HOME:' .. line)
  --       end
  --     end
  --   end
  -- )

  -- local storageDir = awful.widget.watch(
  --   'df -h --output=avail /home/storage',
  --   30,
  --   function(widget, stdout)
  --     for line in stdout:gmatch('[^\r\n]+') do
  --       if line ~= 'Avail' then
  --         widget:set_text('STORAGE:' .. line)
  --       end
  --     end
  --   end
  -- )

  -- local storageDir1 = awful.widget.watch(
  --   'df -h --output=avail /home/storage4GB',
  --   30,
  --   function(widget, stdout)
  --     for line in stdout:gmatch('[^\r\n]+') do
  --       if line ~= 'Avail' then
  --         widget:set_text('STORAGE_1:' .. line)
  --       end
  --     end
  --   end
  -- )

  -- local sysdir = awful.widget.watch(
  --   'df -h --output=avail /',
  --   30,
  --   function(widget, stdout)
  --     for line in stdout:gmatch('[^\r\n]+') do
  --       if line ~= 'Avail' then
  --         widget:set_text('FS:' .. line)
  --       end
  --     end
  --   end
  -- )
  -- Create the wibox
  -- s.mywibox = awful.wibar({position = "bottom", screen = s})
  s.mywibox = awful.wibar({ position = 'top', screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup({
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      -- RC.launcher,
      s.mytaglist,
      -- s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      -- mykeyboardlayout,
      -- mymem,
      -- wibox.widget.textbox(" | "),
      -- wibox.widget.textbox(' | '),
      -- sysdir,
      -- wibox.widget.textbox(' | '),
      -- homedir,
      -- wibox.widget.textbox(' | '),
      -- storageDir,
      -- wibox.widget.textbox(' | '),
      -- storageDir1,
      -- wibox.widget.textbox(' | '),
      -- mycpu,
      wibox.widget.textbox(' | '),
      mytextclock,
      wibox.widget.textbox(' '),
      wibox.widget.systray(),
      s.mylayoutbox,
    },
  })
end)
-- }}}
