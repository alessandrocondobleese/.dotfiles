local api = vim.api
local fn = vim.fn
local get_option = api.nvim_get_option_value

local statusline_icons = require('core.icons').statusline_icons

local fileinfo_widget = {}

--- Highlights a string with a given highlight group.
---@param highlight_group string The highlight group to use.
---@param text string The text to highlight.
---@return string The highlighted string.
function fileinfo_widget.highlight_string(highlight_group, text)
  return '%#' .. highlight_group .. '#' .. text .. '%*'
end

--- Inserts grouping separators into a number string.
---@param num number The number to format.
---@param separator string The separator to use (e.g., ",").
---@return string The formatted number string.
function fileinfo_widget.group_number_with_separator(num, separator)
  if num < 999 then
    return tostring(num)
  end

  local num_str = tostring(num)
  return num_str
    :reverse()
    :gsub('(%d%d%d)', '%1' .. separator)
    :reverse()
    :gsub('^,', '')
end

--- Renders the file information widget for the statusline.
---@return string The rendered file information widget string.
function fileinfo_widget.render()
  local file_type = get_option('filetype', {})
  local line_count =
    fileinfo_widget.group_number_with_separator(api.nvim_buf_line_count(0), ',')
  local output_string = fileinfo_widget.highlight_string(
    statusline_icons.fileinfo[1],
    statusline_icons.fileinfo[2]
  ) .. ' '

  if not _G.global_non_programming_modes[file_type] then
    return output_string .. string.format('%3s lines', line_count)
  end

  local word_count_data = fn.wordcount()
  if not word_count_data.visual_words then
    return output_string
      .. string.format(
        '%3s lines  %3s words',
        line_count,
        fileinfo_widget.group_number_with_separator(word_count_data.words, ',')
      )
  end

  local visual_line_count = math.abs(fn.line '.' - fn.line 'v') + 1
  return output_string
    .. string.format(
      '%3s lines %3s words  %3s chars',
      fileinfo_widget.group_number_with_separator(visual_line_count, ','),
      fileinfo_widget.group_number_with_separator(
        word_count_data.visual_words,
        ','
      ),
      fileinfo_widget.group_number_with_separator(
        word_count_data.visual_chars,
        ','
      )
    )
end

return fileinfo_widget

