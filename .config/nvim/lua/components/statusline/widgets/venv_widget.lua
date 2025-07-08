local bo = vim.bo
local fn = vim.fn

local venv_widget = {}

--- Highlights a string with a given highlight group.
---@param highlight_group string The highlight group to use.
---@param text string The text to highlight.
---@return string The highlighted string.
function venv_widget.highlight_string(highlight_group, text)
  return '%#' .. highlight_group .. '#' .. text .. '%*'
end

--- Renders the Python virtual environment widget for the statusline.
---@return string The rendered virtual environment widget string.
function venv_widget.render()
  if bo.filetype ~= 'python' then
    return ''
  end
  local environment_variable = vim.env.VIRTUAL_ENV

  local display_string
  if environment_variable and environment_variable ~= '' then
    display_string =
      string.format('[.venv: %s]  ', fn.fnamemodify(environment_variable, ':t'))
    return venv_widget.highlight_string('Comment', display_string)
  end
  environment_variable = vim.env.CONDA_DEFAULT_ENV
  if environment_variable and environment_variable ~= '' then
    display_string = string.format('[conda: %s]  ', environment_variable)
    return venv_widget.highlight_string('Comment', display_string)
  end
  return venv_widget.highlight_string('Comment', '[no venv]')
end

return venv_widget

