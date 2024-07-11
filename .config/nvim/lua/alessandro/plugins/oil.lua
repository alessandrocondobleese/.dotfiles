return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  config = function()
    local oil = require "oil"
    oil.setup {
      keymaps = {
        ["<C-h>"] = false,
      },
      view_options = {
        show_hidden = true,
        natural_order = true,
      },
    }

    vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory using Oil" })
  end,
}
