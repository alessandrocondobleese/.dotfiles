local M = {}

function M.setup()
  vim.g.mapleader = " "

  vim.keymap.set("n", "q", "<nop>", { noremap = true, silent = true })
  vim.keymap.set("n", "@", "<nop>", { noremap = true, silent = true })

  vim.keymap.set("n", "<leader>q", ":qa<cr>")
  vim.keymap.set("n", "<leader>Q", ":qa!<cr>")

  vim.keymap.set("n", "<leader>s", ":w<cr>")
end

return M
