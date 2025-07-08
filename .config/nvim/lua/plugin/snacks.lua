---@type SnacksOpts
return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    picker = {
      ---@class snacks.picker.icons
      icons = {
        files = {
          enabled = false,
        },
      },

      layout = 'sidebar',
    },
  },
  keys = {
    {
      '<leader>ff',
      --- Opens the file picker.
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>/',
      --- Opens the grep picker.
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    -- GIT
    {
      '<leader>gl',
      --- Opens the git log picker.
      function()
        Snacks.picker.git_log()
      end,
      desc = 'Git Log',
    },
    -- LSP
    {
      '<leader>cR',
      --- Renames the current file.
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'Rename File',
    },
  },
}
