vim.keymap.set("n", "q", "<nop>", { noremap = true, silent = true, desc = "Unmap q" })
vim.keymap.set("n", "@", "<nop>", { noremap = true, silent = true, desc = "Unmap @" })

vim.keymap.set("n", "<leader>q", ":qa<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":qa!<cr>", { desc = "Quit force" })

vim.keymap.set("n", "<leader>s", ":w<cr>", { desc = "Save current buffer" })
