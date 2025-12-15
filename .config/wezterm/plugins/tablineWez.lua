local wezterm = require('wezterm')

local tabline =
  wezterm.plugin.require('https://github.com/michaelbrusegard/tabline.wez')

-- local spotify = require('plugins.mySpotifyPlugin')

local M = {}

-- spotify configs
local spotifyGreen = '#2fb170'
-- spotify.setup(100, 5)

M.setup = function(config)
  tabline.setup({
    options = {
      icons_enabled = true,
      -- theme = 'Catppuccin Mocha',
      theme = 'Dracula',
      tabs_enabled = true,
      theme_overrides = {},
      section_separators = '',
      component_separators = '',
      tab_separators = '',
    },
    sections = {
      tabline_a = { 'workspace' },
      tabline_b = { '' },
      tabline_c = { '' },
      tab_active = {
        'index',
        { 'zoomed', padding = 0 },
        { 'process', padding = { left = 0, right = 1 } },
      },
      tab_inactive = {
        'index',
        { 'process', padding = { left = 0, right = 1 } },
      },
      tabline_x = {
        { Foreground = { Color = spotifyGreen } },
        -- spotify.get_currently_playing,
      },
      tabline_y = { { 'ram', throttle = 5 }, { 'cpu', throttle = 5 } },
      tabline_z = { 'domain' },
    },
    extensions = {},
  })

  tabline.apply_to_config(config)
end

return M
