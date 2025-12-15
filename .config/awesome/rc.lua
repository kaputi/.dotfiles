-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

-- Standard awesome library
-- local gears = require("gears")
local awful = require('awful')
require('awful.autofocus')
-- Theme handling library
-- local beautiful = require("beautiful")

-- Miscellanous awesome library
-- local menubar = require("menubar")

RC = {} -- global namespace, on top before require any modules

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

RC.vars = require('main.user-variables')

modkey = RC.vars.modkey

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Error handling
-- require("main.error-handling")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
--  Themes
require('main.theme')

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Custom Local Library
local main = {
  layouts = require('main.layouts'),
  tags = require('main.tags'),
  -- menu = require("main.menu"),
  rules = require('main.rules'),
}

-- Custom Local Library: Keys and Mouse Binding
local binding = {
  globalbuttons = require('binding.globalbuttons'),
  clientbuttons = require('binding.clientbuttons'),
  globalkeys = require('binding.globalkeys'),
  bindtotags = require('binding.bindtotags'),
  clientkeys = require('binding.clientkeys'),
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Layouts
-- Table of layouts to cover with awful.layout.inc, order matters.
-- a variable needed in main.tags, and statusbar
-- awful.layout.layouts = { ... }
RC.layouts = main.layouts()
awful.layout.layouts = RC.layouts

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Tags
-- Define a tag table which hold all screen tags.
-- a variable needed in rules, tasklist, and globalkeys
RC.tags = main.tags()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Menu
-- Create a laucher widget and a main menu
-- RC.mainmenu = awful.menu({items = main.menu()}) -- in globalkeys

-- a variable needed in statusbar (helper)
-- RC.launcher = awful.widget.launcher({
--   image = beautiful.awesome_icon,
--   menu = RC.mainmenu
-- })

-- Menubar configuration
-- Set the terminal for applications that require it
-- menubar.utils.terminal = RC.vars.terminal

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Mouse and Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)

--  Statusbar: Wibar
require('deco.statusbar')

--  Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = main.rules(binding.clientkeys(), binding.clientbuttons())
--

-- Signals
require('main.signals')
--

-- autolaunch
-- awful.spawn.with_shell(
--     "nitrogen --set-zoom-fill --random ~/Pictures/WallpapersDev/")
awful.spawn.with_shell('/home/eduardo/.screenlayout/MyScreenLayout.sh')
awful.spawn.with_shell('nitrogen --set-zoom-fill --restore')
-- awful.spawn.with_shell("dunst")
awful.spawn.with_shell('traylaunch.sh')
-- awful.spawn.with_shell("xbindkeys")
-- awful.spawn.with_shell("batteryAlert.sh")
-- awful.spawn.with_shell("emacs --daemon")
awful.spawn.with_shell(
  '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1'
)
-- awful.spawn.with_shell("capsEscape")
awful.spawn.with_shell('birdtray')

awful.spawn.with_shell('picom -b')

awful.spawn.with_shell('/home/eduardo/.local/bin/restartNotification.sh')

-- beautiful.useless_gap = 5

-- beautiful.gap_single_client = false
