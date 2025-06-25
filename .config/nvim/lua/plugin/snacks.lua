return {
  "folke/snacks.nvim",
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

      layout = "sidebar",
    },
  },
  keys = {
    -- Top Pickers & Explorer
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    -- GIT
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git Log",
    },
    -- LSP
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
  },
}
