-- Standard awesome library
local awful = require('awful')

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
  local tags = {}

  awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    local defaultLayout = 2 -- layout 3 is tile.left
    if s.index == 2 then -- second screeen is tile.bottom
      defaultLayout = 3
    end

    tags[s] = awful.tag(
      { '1', '2', '3', '4', '5', '6', '7', '8', '9' },
      s,
      RC.layouts[defaultLayout]
    )

    s.padding = { top = 0, left = 0, right = 0, bottom = 0 }
  end)

  return tags
end

-- awful.screen.connect_for_each_screen(function(s)
--     -- Debug: print screen info
--     naughty = require("naughty")
--     naughty.notify({ 
--         text = "Screen " .. s.index .. ": " .. s.geometry.width .. "x" .. s.geometry.height 
--     })
--     
--     local defaultLayout = 2
--     if s.index == 2 then
--       defaultLayout = 3
--     elseif s.index == 3 then  -- Your virtual monitor!
--       defaultLayout = 2  -- or whatever you want
--     end
--     
--     tags[s] = awful.tag(
--       { '1', '2', '3', '4', '5', '6', '7', '8', '9' },
--       s,
--       RC.layouts[defaultLayout]
--     )
--     s.padding = { top = 0, left = 0, right = 0, bottom = 0 }
-- end)

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, {
  __call = function(_, ...)
    return _M.get(...)
  end,
})
