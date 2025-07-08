local api = vim.api

local scrollbar_widget = {}

--- Highlights a string with a given highlight group.
---@param highlight_group string The highlight group to use.
---@param text string The text to highlight.
---@return string The highlighted string.
function scrollbar_widget.highlight_string(highlight_group, text)
  return '%#' .. highlight_group .. '#' .. text .. '%*'
end

--- Renders the scrollbar widget for the statusline.
---@return string The rendered scrollbar widget string.
function scrollbar_widget.render()
  local scrollbar_characters =
    { '▔', '🮂', '🬂', '🮃', '▀', '▄', '▃', '🬭', '▂', ' ' }
  local current_line = api.nvim_win_get_cursor(0)[1]
  local total_lines = api.nvim_buf_line_count(0)
  local character_index = math.floor(
    (current_line - 1) / total_lines * #scrollbar_characters
  ) + 1
  return scrollbar_widget.highlight_string(
    'Substitute',
    scrollbar_characters[character_index]:rep(2)
  )
end

return scrollbar_widget

