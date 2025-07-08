local icons = require('core.icons').kind_icons
return {
  'Bekaboo/dropbar.nvim',
  opts = {
    icons = {
      ui = { bar = { separator = ' ' .. '>' } },
      ---@type table<string, string>
      kinds = {
        symbols = icons,
      },
    },
    bar = {
      --- Determines if the dropbar should be enabled for a given buffer and window.
      ---@param buffer number The buffer number.
      ---@param window number The window ID.
      ---@param _ any Unused parameter.
      ---@return boolean True if the dropbar should be enabled, false otherwise.
      enable = function(buffer, window, _)
        if
          not vim.api.nvim_buf_is_valid(buffer)
          or not vim.api.nvim_win_is_valid(window)
          or vim.fn.win_gettype(window) ~= ''
          or vim.wo[window].winbar ~= ''
          or vim.bo[buffer].ft == 'help'
        then
          return false
        end

        local file_stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buffer))
        if file_stat and file_stat.size > 1024 * 1024 then
          return false
        end

        return vim.bo[buffer].ft == 'markdown'
          or vim.bo[buffer].ft == 'text'
          or vim.bo[buffer].bt == ''
          or pcall(vim.treesitter.get_parser, buffer)
          or not vim.tbl_isempty(vim.lsp.get_clients {
            bufnr = buffer,
            method = 'textDocument/documentSymbol',
          })
      end,
      update_debounce = 100,
      --- Defines the sources for the dropbar.
      ---@param buffer number The buffer number.
      ---@param _ any Unused parameter.
      ---@return table A table of dropbar sources.
      sources = function(buffer, _)
        local dropbar_sources = require 'dropbar.sources'
        local dropbar_utils = require 'dropbar.utils'

        if vim.bo[buffer].ft == 'markdown' then
          return { dropbar_sources.markdown }
        end
        if vim.bo[buffer].buftype == 'terminal' then
          return { dropbar_sources.terminal }
        end
        return {
          dropbar_utils.source.fallback {
            dropbar_sources.lsp,
            dropbar_sources.treesitter,
          },
        }
      end,
    },
  },
}
