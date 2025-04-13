local wez = require('wezterm')

---waits for a specified throttle time before proceeding.
---@param throttle number
---@param last_update number
---@return boolean
local wait = function(throttle, last_update)
  local current_time = os.time()
  return current_time - last_update < throttle
end

---trim string from trailing spaces and newlines
---@param s string
---@return string
local trim = function(s)
  return s:match('^%s*(.-)%s*$')
end

---@private
---@class bar.spotify
local M = {}

---format spotify playback, to handle max_width nicely
---@param pb string
---@param max_width number
---@return string
local format_playback = function(pb, max_width)
  if #pb <= max_width then
    return pb
  end

  -- split on " - "
  local artist, track = pb:match('^(.-) %- (.+)$')
  -- get artist before first ","
  local pb_main_artist = artist:match('([^,]+)') .. ' - ' .. track
  if #pb_main_artist <= max_width then
    return pb_main_artist
  end

  -- fallback, return track name (trimmed to max width)
  return track:sub(1, max_width)
end

local stored_playback = ''
local last_update = -1

local max_width = 50
local throttle = 10

M.setup = function(max_width_, throttle_)
  max_width = max_width_
  throttle = throttle_
end

---gets the currently playing song from spotify
---@return string
M.get_currently_playing = function()
  if wait(throttle, last_update) then
    return stored_playback
  end
  -- fetch playback using spotify-tui
  local success, pb, stderr =
    wez.run_child_process({ 'spt', 'pb', '--format', '%a - %t' })
  if not success then
    wez.log_error(stderr)
    return ''
  end
  local res = format_playback(trim(pb), max_width - 2)
  res = ' 󰝚 ' .. res .. ' 󰝚 '
  stored_playback = res
  last_update = os.time()

  return res
end

return M
