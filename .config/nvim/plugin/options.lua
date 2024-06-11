-- Enable faster Lua loader using byte-compilation
vim.loader.enable()

-- UI and Visual Enhancements
-- Highlight the column at the 80th character to aid in maintaining line length
vim.opt.colorcolumn = "80"
-- Highlight the line where the cursor is located for better visibility
vim.opt.cursorline = true
-- Disable the display of the current mode (e.g., INSERT) at the bottom of the window
vim.opt.showmode = false
-- Display line numbers on the left side of the window
vim.opt.number = true
-- Display the cursor's current position in the status line
vim.opt.ruler = true
-- Show relative line numbers instead of absolute line numbers
vim.opt.relativenumber = true
-- Customize the width and content of the number column
vim.opt.numberwidth = 4
-- Enable 24-bit RGB color in the terminal
vim.opt.termguicolors = true
-- Highlight matching parentheses and other characters
vim.opt.showmatch = true

-- Indentation and Text Editing
-- Use spaces instead of tabs for indentation
vim.opt.expandtab = true
-- Set the number of space characters inserted for indentation
vim.opt.shiftwidth = 2
-- Set the number of spaces that a tab character represents
vim.opt.tabstop = 2
-- Set the number of spaces to use for autoindent and tab completion
vim.opt.softtabstop = 2
-- Enable smart indentation, which adjusts based on the syntax/context
vim.opt.smartindent = true
-- Enable smooth scrolling for more fluid navigation in documents
vim.opt.smoothscroll = true
-- Prevent text lines from wrapping around to the next line
vim.opt.wrap = false
-- Break lines at whitespace characters to avoid broken words at the window's edge
vim.opt.linebreak = true
-- Maintain the indentation level of a line when it wraps or breaks
vim.opt.breakindent = true

-- Files and Backup
-- Disable swap file creation to prevent saving temporary state to disk
vim.opt.swapfile = false
-- Disable backup file creation to prevent generating backup files
vim.opt.backup = false
-- Set the directory for storing undo history and enable undo files
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undo"
vim.opt.undofile = true

-- Search
-- Disable highlighting all search matches
vim.opt.hlsearch = false
-- Enable incremental search that shows results as you type
vim.opt.incsearch = true
--
vim.opt.smartcase = true
--
vim.opt.ignorecase = true
--
vim.opt.inccommand = "split"

-- System Clipboard and External Tools
-- Use system clipboard for copy-paste operations
vim.opt.clipboard:append "unnamedplus"
-- Terminal cursor shape settings
vim.cmd [[let &t_Cs = "\e[4:3m"]] -- Start cursor shape
vim.cmd [[let &t_Ce = "\e[4:0m"]] -- End cursor shape
-- Highlight spelling errors with an underline
vim.cmd [[highlight SpellBad cterm=undercurl gui=undercurl]]

-- Plugin and Additional Features
-- Disable the default Netrw file explorer plugin
vim.g.loaded_netrw = 1
-- Disable additional Netrw plugin feature
vim.g.loaded_netrwPlugin = 1

--
vim.opt.completeopt = { "menu", "menuone", "noselect" }
--
vim.opt.shortmess:append "c"
---
vim.opt.splitbelow = true
vim.opt.splitright = true
