local M = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { 'nvim-telescope/telescope-fzf-native.nvim',  build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "debugloop/telescope-undo.nvim" }
  },
  keys = {
    {
      "<leader>ff",
      function()
        local builtin = require("telescope.builtin")
        builtin.find_files({
          no_ignore = false,
          hidden = true,
        })
      end,
      desc = "Lists files in your current working directory, respects .gitignore",
    },
    {
      "<leader>fg",
      function()
        local builtin = require("telescope.builtin")
        builtin.live_grep()
      end,
      desc =
      "Search for a string in your current working directory and get results live as you type, respects .gitignore",
    },
    {
      "<leader>\\\\",
      function()
        local telescope = require("telescope")

        local function telescope_buffer_dir()
          return vim.fn.expand("%:p:h")
        end

        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 },
        })
      end,
      desc = "Open File Browser with the path of the current buffer",
    },
    {
      "<leader>u",
      "<cmd>Telescope undo<cr>",
      desc = "Undo History"
    }
  }
}

function M.config()
  require("telescope").setup({
    defaults = {
      file_ignore_patterns = {
        "node_modules",
        "dist",
      },
    },
    extensions = {
      undo = {
        use_delta = true,
        side_by_side = true,
        layout_strategy = "vertical",
        layout_config = {
          preview_height = 0.8,
        },
      },
    },
  })

  require('telescope').load_extension('fzf')
  require("telescope").load_extension("file_browser")
  require("telescope").load_extension("undo")


  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
end

return M
