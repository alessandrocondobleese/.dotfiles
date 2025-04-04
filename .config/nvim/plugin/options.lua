-- Enable faster Lua loader using byte-compilation
vim.loader.enable()

-- Indentation and Text Formatting
vim.o.expandtab = true -- Use spaces instead of tabs for indentation
vim.opt.shiftwidth = 2 -- Number of spaces per indentation level
vim.o.shiftround = true -- Round indent to the nearest multiple of shiftwidth
vim.opt.tabstop = 2 -- Number of spaces that a tab character represents
vim.opt.softtabstop = 2 -- Spaces per tab when inserting/deleting
vim.opt.smartindent = true -- Enable smart indentation
vim.opt.linebreak = true -- Break lines at whitespace
vim.opt.breakindent = true -- Maintain indentation on line breaks
vim.o.breakindentopt = "list:-1" -- Fine-tune break indentation behavior

-- Clipboard
vim.opt.clipboard:append "unnamedplus" -- Use system clipboard

-- UI Enhancements
vim.o.cursorline = true -- Highlight the cursor line
vim.opt.cursorlineopt = { "number" } -- Highlight only the number column
vim.o.colorcolumn = "+0" -- Highlight the 80th character column
vim.o.foldcolumn = "1" -- Show fold column
vim.o.foldenable = false -- Disable folding by default
vim.o.foldlevel = 99 -- Maximum fold level
vim.o.foldtext = vim.lsp.foldtext() -- Use LSP for fold text
vim.o.laststatus = 3 -- Global status line
vim.o.list = true -- Show special characters
vim.opt.listchars = { nbsp = "␣", tab = "  ", trail = "·" } -- Customize list characters
vim.o.mouse = "" -- Disable mouse support
vim.opt.showmode = false -- Hide mode display (redundant with statusline)
vim.opt.showcmd = false -- Hide command display
vim.o.wildmode = "longest:full" -- Command-line completion mode
vim.o.wildoptions = "pum" -- Use popup menu for completion
vim.o.redrawtime = 150 -- Set redraw time for large files
vim.o.titlestring = "nvim: %t" -- Window title format
vim.o.title = true -- Enable window title
vim.o.splitkeep = "screen" -- Keep split screen position
vim.o.splitright = true -- New splits appear to the right
vim.o.splitbelow = true -- New splits appear below
vim.o.scrolloff = 30 -- Minimum lines above/below cursor
vim.o.sidescrolloff = 30 -- Minimum columns left/right of cursor
vim.o.signcolumn = "yes:1" -- Always show sign column

-- Cursor Appearance
vim.opt.guicursor = {
  "n-sm:block", -- Block cursor in normal/select modes
  "v:hor50", -- 50% horizontal cursor in visual mode
  "c-ci-cr-i-ve:ver10", -- Thin vertical cursor in command/insert modes
  "o-r:hor10", -- Thin horizontal cursor in operator/replacement mode
  "a:Cursor/Cursor-blinkwait1-blinkon1-blinkoff1", -- Blinking animation
}

-- Window Separators and Fill Characters
vim.opt.fillchars = {
  eob = " ",
  diff = "╱",
  fold = " ",
  foldsep = " ",
  msgsep = "━",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}

-- Line Numbers
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.numberwidth = 3 -- Set width of number column

-- Colors and Visual Effects
vim.opt.termguicolors = true -- Enable 24-bit RGB color
vim.opt.showmatch = true -- Highlight matching brackets
vim.o.pumheight = 15 -- Maximum popup menu height

-- File Handling and Backups
vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false -- Disable backup files
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undo" -- Undo history directory
vim.opt.undofile = true -- Enable persistent undo

-- Search Behavior
vim.opt.hlsearch = false -- Disable highlight search
vim.opt.incsearch = true -- Enable incremental search
vim.opt.smartcase = true -- Smart case-sensitive search
vim.opt.ignorecase = true -- Ignore case in searches unless uppercase is used
vim.opt.inccommand = "split" -- Show incremental command results in split

-- Plugin and Additional Features
vim.g.loaded_netrw = 1 -- Disable default Netrw file explorer
vim.g.loaded_netrwPlugin = 1 -- Disable additional Netrw features
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Completion menu behavior
vim.opt.shortmess:append "c" -- Shorten completion messages

vim.api.nvim_set_hl(0, "SpellBad", { underline = true })
