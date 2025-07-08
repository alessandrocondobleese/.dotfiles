local config = {}

---@type table<string, boolean>
_G.global_non_programming_modes = {
  ['markdown'] = true,
  ['org'] = true,
  ['orgagenda'] = true,
  ['text'] = true,
}

--- Sets up global Neovim configurations.
function config.setup()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = '\\'
end

return config
