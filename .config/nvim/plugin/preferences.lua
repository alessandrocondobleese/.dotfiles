---@class Preferences
local preferences = {}

--- Sets up Neovim preferences.
function preferences.setup()
  -- Clipboard
  vim.opt.clipboard:append 'unnamedplus'
  -- Use the system clipboard (register +) as the default clipboard

  -- UI
  vim.o.confirm = true
  -- Allow confirming changes before closing modified files

  vim.o.cursorline = true
  -- Highlight the current cursor line

  vim.opt.cursorlineopt = { 'number' }
  -- Only highlight the line number instead of the entire line

  vim.o.modeline = false
  vim.o.modelines = 0
  -- Disable modelines (for security)

  -- Edit
  vim.o.tabstop = 2
  vim.o.expandtab = true
  -- Convert tabs to spaces

  vim.o.softtabstop = -1
  -- Use the value of shiftwidth when pressing Tab in insert mode

  vim.o.shiftwidth = 0
  -- Use the value of 'tabstop' as indent width

  vim.o.shiftround = true
  -- Adjust indentation to the nearest multiple of 'shiftwidth'

  vim.o.virtualedit = 'all'
  -- Allow moving the cursor to "empty" positions, useful in visual block

  -- Splits
  vim.o.splitright = true
  -- New vertical windows open to the right

  vim.o.splitbelow = true
  -- New horizontal windows open below

  vim.o.equalalways = true
  -- Always equalize window sizes when splitting

  vim.o.splitkeep = 'screen'
  -- Keep the screen stable when splitting windows

  -- Scroll
  vim.o.scrolloff = 30
  -- Minimum of 30 lines above and below the cursor

  vim.o.sidescrolloff = 30
  -- Minimum of 30 columns to the left and right of the cursor

  vim.o.cmdwinheight = 30
  -- Height of the command window (:q, etc.)

  vim.o.colorcolumn = '+0'
  -- Show a guide column at 'textwidth' position (if defined)

  vim.o.list = true
  -- Show invisible characters

  vim.opt.listchars = {
    nbsp = '␣', -- Non-breaking space
    tab = '  ', -- Visual representation of tab
    trail = '·', -- Trailing spaces at the end of the line
  }

  -- Status lines
  vim.o.laststatus = 3
  -- Show a single global status line

  vim.o.showtabline = 1
  -- Show tab line only if there are multiple tabs

  vim.o.showmode = false
  -- Hide messages like "-- INSERT --" (useful if using a custom status bar)

  vim.o.showcmd = false
  -- Do not show partially typed commands at the bottom

  vim.o.inccommand = 'split'
  -- Show substitution results (`:s///`) in real-time in a split window

  -- Lines
  vim.o.number = true
  -- Show absolute line number

  vim.o.relativenumber = true
  -- Show relative numbers (useful for navigating with movements like `5j`)

  vim.o.numberwidth = 3
  -- Minimum width of the number column

  -- Break lines
  vim.o.linebreak = true
  -- Break lines only at spaces to avoid cutting words

  vim.o.breakindent = true
  -- Keep wrapped text indented

  vim.o.breakindentopt = 'list:-1'
  -- Adjust indentation behavior for long lines

  -- Cursor
  vim.opt.guicursor = {
    'n-sm:block', -- Block in normal and select mode
    'v:hor50', -- Horizontal cursor at 50% in visual mode
    'c-ci-cr-i-ve:ver10', -- Thin vertical cursor in insert, command, replace, etc.
    'o-r:hor10', -- Thin horizontal cursor in operator and replace mode
    'a:Cursor/Cursor-blinkwait1-blinkon1-blinkoff1', -- Custom blinking for all modes
  }
end

return preferences