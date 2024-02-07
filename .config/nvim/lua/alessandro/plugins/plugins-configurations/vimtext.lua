local M = {
  "lervag/vimtex"
}

function M.config()
  vim.cmd('filetype plugin indent on')
  vim.cmd('syntax enable')
  vim.g.vimtex_indent_enabled = 1
end

return M
