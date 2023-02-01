local keymap = {}

function keymap.setup()
	vim.g.mapleader = " "

	vim.keymap.set("n", "<leader>q", ":qa<cr>")
	vim.keymap.set("n", "<leader>Q", ":qa!<cr>")

	vim.keymap.set("n", "<leader>s", ":w<cr>")

	vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
	vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
end

keymap.setup()

return keymap
