vim.opt.clipboard:append("unnamedplus")

--- UI
vim.o.splitright = true -- New splits appear to the right
vim.o.splitbelow = true -- New splits appear below
vim.o.scrolloff = 30 -- Minimum lines above/below cursor
vim.o.sidescrolloff = 30 -- Minimum columns left/right of cursor

-- Line Numbers
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.numberwidth = 3 -- Set width of number column

vim.opt.guicursor = {
	"n-sm:block", -- Block cursor in normal/select modes
	"v:hor50", -- 50% horizontal cursor in visual mode
	"c-ci-cr-i-ve:ver10", -- Thin vertical cursor in command/insert modes
	"o-r:hor10", -- Thin horizontal cursor in operator/replacement mode
	"a:Cursor/Cursor-blinkwait1-blinkon1-blinkoff1", -- Blinking animation
}
