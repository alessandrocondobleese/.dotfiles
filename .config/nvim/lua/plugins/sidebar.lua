local sidebar = {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}

function sidebar.config()
  require("nvim-tree").setup()
  vim.keymap.set("n", "<leader>\\", ":NvimTreeFocus<cr>")
end

return sidebar
