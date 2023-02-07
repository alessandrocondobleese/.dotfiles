local defaults = {}

function defaults.setup()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
	-- Indentation
	vim.opt.expandtab = true
	vim.opt.shiftwidth = 2
	vim.opt.tabstop = 2
	vim.opt.softtabstop = 2
	vim.opt.smartindent = true

	-- Undo
	vim.opt.swapfile = false
	vim.opt.backup = false
	vim.opt.undodir = os.getenv("HOME") .. "/.vim/undo"
	vim.opt.undofile = true

	-- Search
	vim.opt.hlsearch = false
	vim.opt.incsearch = true

	-- Terminal colors
	vim.opt.termguicolors = true

	-- UI
	vim.opt.wrap = false
	vim.opt.scrolloff = 8
	vim.opt.cursorline = true
	vim.opt.showmatch = true
	vim.opt.completeopt = { "menuone", "noselect" }
	vim.opt.number = true
	vim.opt.signcolumn = "yes"
	vim.opt.relativenumber = true

	vim.opt.updatetime = 50
end

defaults.setup()

return defaults
