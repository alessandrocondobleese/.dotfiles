---@class Statusline
local Statusline = {}
Statusline.__index = Statusline

local api = vim.api
local fn = vim.fn
local bo = vim.bo
local get_option = api.nvim_get_option_value

local statusline_icons = require('core.icons').statusline_icons

local diagnostics_widget =
  require 'components.statusline.widgets.diagnostics_widget'
local fileinfo_widget = require 'components.statusline.widgets.fileinfo_widget'
local path_widget = require 'components.statusline.widgets.path_widget'
local scrollbar_widget =
  require 'components.statusline.widgets.scrollbar_widget'
local venv_widget = require 'components.statusline.widgets.venv_widget'

---@class StatuslineHighlight
---@field branch table
---@field file table
---@field fileinfo table
---@field nomodifiable table
---@field modified table
---@field readonly table
---@field error table
---@field warn table
---@field visual table

---@type string[]
local widget_order = {
  'pad',
  'path',
  'venv',
  'mod',
  'ro',
  'sep',
  'diag',
  'fileinfo',
  'pad',
  'scrollbar',
  'pad',
}

local padding = ' '
local separator = '%='

--- Concatenates statusline parts into a single string.
---@param parts table A table containing the parts of the statusline.
---@return string The concatenated statusline string.
local function concatenate_parts(parts)
  local output, index = {}, 1
  for _, key in ipairs(widget_order) do
    local value = parts[key]
    if value and value ~= '' then
      output[index] = value
      index = index + 1
    end
  end
  return table.concat(output, ' ')
end

--- Renders the statusline.
---@return string The rendered statusline string.
function Statusline:render()
  local file_name = api.nvim_buf_get_name(0)
  local root_path = (bo.buftype == '' and path_widget.get_path_root(file_name))
    or nil
  if bo.buftype ~= '' and bo.buftype ~= 'help' then
    file_name = bo.ft
  end

  local buffer = api.nvim_win_get_buf(vim.g.statusline_winid)

  local parts = {
    pad = padding,
    path = path_widget.render(root_path, file_name),
    venv = venv_widget.render(),
    mod = get_option('modifiable', { buf = buffer })
        and (get_option('modified', { buf = buffer }) and path_widget.highlight_string(
          statusline_icons.modified[1],
          statusline_icons.modified[2]
        ) or ' ')
      or path_widget.highlight_string(
        statusline_icons.nomodifiable[1],
        statusline_icons.nomodifiable[2]
      ),
    ro = get_option('readonly', { buf = buffer })
        and path_widget.highlight_string(
          statusline_icons.readonly[1],
          statusline_icons.readonly[2]
        )
      or '',
    sep = separator,
    diag = diagnostics_widget.render(),
    fileinfo = fileinfo_widget.render(),
    scrollbar = scrollbar_widget.render(),
  }

  return concatenate_parts(parts)
end

--- Creates a new Statusline object.
---@return Statusline A new Statusline object.
function Statusline:new()
  local object = setmetatable({}, Statusline)
  return object
end

return Statusline
