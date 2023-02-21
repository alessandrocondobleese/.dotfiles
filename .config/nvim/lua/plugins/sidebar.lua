local sidebar = {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}

function sidebar.root_label(path)
  print(path)
  path = path:gsub('/Users/alessandroaguilar', ' ') .. '/'
  local path_len = path:len()
  local win_nr = require('nvim-tree.view').get_winnr()
  local win_width = vim.fn.winwidth(win_nr)
  if path_len > (win_width - 2) then
    local max_str = path:sub(path_len - win_width + 5)
    local pos = max_str:find('/')
    if pos then
      return '󰉒 ' .. max_str:sub(pos)
    else
      return '󰉒 ' .. max_str
    end
  end
  return path
end

function sidebar.config()
  require("nvim-tree").setup({
    hijack_cursor = true,
    sync_root_with_cwd = true,
    view = {
      signcolumn = "no",
      width = {
        max = 40,
        min = 40,
        padding = 1,
      },
    },
    renderer = {
      root_folder_label = sidebar.root_label,
      indent_width = 2,

      indent_markers = {
        enable = true,
        inline_arrows = true,
        icons = {
          corner = "╰",
        },
      },
      icons = {
        git_placement = "after",
        modified_placement = "after",
        padding = " ",
        glyphs = {
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = " ",
            open = " ",
            empty = " ",
            empty_open = " ",
            symlink = "󰉒 ",
            symlink_open = "󰉒 ",
          },
          git = {
            deleted = "",
            unstaged = "",
            untracked = "",
            staged = "",
            unmerged = "",
          },
        },
      },
    },
  })
  vim.keymap.set("n", "<leader>\\", ":NvimTreeFocus<cr>")
end

return sidebar
