local statusline_icons = require('core.icons').statusline_icons

local diagnostics_widget = {}

--- Highlights a string with a given highlight group.
---@param highlight_group string The highlight group to use.
---@param text string The text to highlight.
---@return string The highlighted string.
function diagnostics_widget.highlight_string(highlight_group, text)
  return '%#' .. highlight_group .. '#' .. text .. '%*'
end

--- Checks if diagnostics are available for the current buffer.
---@return boolean True if diagnostics are available, false otherwise.
function diagnostics_widget.are_diagnostics_available()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  local diagnostics_method =
    vim.lsp.protocol.Methods.textDocument_publishDiagnostics

  for _, client_config in pairs(clients) do
    if client_config:supports_method(diagnostics_method) then
      return true
    end
  end

  return false
end

--- Renders the diagnostics widget for the statusline.
---@return string The rendered diagnostics widget string.
function diagnostics_widget.render()
  if not diagnostics_widget.are_diagnostics_available() then
    return ''
  end
  local diagnostic_count = vim.diagnostic.count()
  local errors = diagnostic_count[1] or 0
  local warnings = diagnostic_count[2] or 0
  return string.format(
    '%s %-3d  %s %-3d  ',
    diagnostics_widget.highlight_string(
      statusline_icons.error[1],
      statusline_icons.error[2]
    ),
    errors,
    diagnostics_widget.highlight_string(
      statusline_icons.warn[1],
      statusline_icons.warn[2]
    ),
    warnings
  )
end

return diagnostics_widget

