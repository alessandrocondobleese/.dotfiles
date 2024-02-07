local M = { "catppuccin/nvim", name = "catppuccin", priority = 1000 }

function M.config()
  require("catppuccin").setup({
    integrations = {
      telescope = {
        enabled = true,
      },
      treesitter = true,
    }
  })

  vim.cmd.colorscheme "catppuccin-mocha"
end

return M
