-- Standard awesome library
local awful = require('awful')
-- Theme handling library
local beautiful = require('beautiful')

local _M = {}

-- reading
-- https://awesomewm.org/apidoc/libraries/awful.rules.html

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get(clientkeys, clientbuttons)
  local rules = {

    -- All clients will match this rule.
    {
      rule = {},
      properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      },
    }, -- Floating clients.
    {
      rule_any = {
        instance = {
          'DTA', -- Firefox addon DownThemAll.
          'copyq', -- Includes session name in class.
          'pinentry',
        },
        class = {
          'Arandr',
          'Blueman-manager',
          'Gpick',
          'Kruler',
          'MessageWin', -- kalarm.
          'Sxiv',
          'Tor Browser', -- Needs a fixed window size to avoid fingerprinting by screen size.
          'Wpa_gui',
          'veromix',
          'xtightvncviewer',
          'qalculate-gtk',
          'Qalculate-gtk',
        },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          'Event Tester', -- xev.
          'Qalculate!',
        },
        role = {
          'AlarmWindow', -- Thunderbird's calendar.
          'ConfigManager', -- Thunderbird's about:config.
          'pop-up', -- e.g. Google Chrome's (detached) Developer Tools.
        },
      },
      properties = { floating = true },
    }, -- Add titlebars to normal clients and dialogs
    {
      rule_any = { type = { 'normal', 'dialog' } },
      properties = { titlebars_enabled = false },
    },
    -- Teams open on tag 9 on screen 1
    {
      rule_any = {
        class = {
          'microsoft teams - insiders',
          'Microsoft Teams - Insiders',
          'Microsoft Teams - Preview',
          'microsoft teams - preview',
          'teams',
          'slack',
          'Slack',
          'teams-for-linux',
          'crx_cifhbcnohmdccbgoicgdjpfamggdegmo',
          'Skype',
          'skype',
        },
        name = {
          'Microsoft Teams - Chat',
          'Microsoft Teams',
          'WhatsApp Web',
          'Skype*',
        },
      },
      properties = {
        screen = 2,
        tag = '9',
        switchtotag = false,
        floating = false,
      },
    },
    {
      rule_any = {
        class = {
          'telegram-desktop',
          'TelegramDesktop',
        },
        name = {
          'WhatsApp Web',
          'Telegram',
        },
      },
      properties = {
        screen = 2,
        tag = '8',
        switchtotag = false,
        floating = false,
      },
    },
    {
      rule_any = {
        class = {
          'spotify',
          'Spotify',
        },
      },
      properties = {
        screen = 2,
        tag = '7',
        switchtotag = false,
        floating = false,
      },
    },
    {
      rule_any = { name = { 'DevTools - *' } },
      properties = { floating = false },
    },
    {
      rule_any = {
        -- name = { '* Mozilla Thunderbird' },
        -- class = { 'Thunderbird' },
        class = { 'Thunderbird', 'thunderbird', 'mail', 'Mail' },
      },
      properties = {
        tag = '5',
        screen = 1,
        switchtotag = false,
        floating = false,
      },
    },

    -- Chrome oppens on tag with name 2 on screen 1
    -- { rule = { class = "Google-chrome" },
    --   properties = { screen = 1, tag = "2", switchtotag = true } },

    -- pcmanfm opens in tag 1
    -- { rule = { class = "Pcmanfm"  },
    --   properties = { screen = 1, tag = "1", switchtotag = true }
    -- },

    -- emacs opens in tag 3
    -- { rule = { class = "Emacs" },
    --   properties = { screen = 1, tag = "3" }
    -- }

    -- Spawn floating clients centered
    -- { rule_any = {floating = true},
    --     properties = {
    --         placement = awful.placement.centered
    --     }
    -- },
  }

  return rules
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, {
  __call = function(_, ...)
    return _M.get(...)
  end,
})
