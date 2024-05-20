local builtin = require "telescope.builtin"
local telescope = require "telescope"

telescope.setup {
  defaults = {
    file_ignore_patterns = {
      ".metals",
      ".bloop",
      "ammonite",
      "metals.sbt",
    },
  },
  extensions = {
    fzf = {},
    wrap_results = true,
  },
}

telescope.load_extension "fzf"

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)

vim.keymap.set("n", "<leader>gs", builtin.grep_string)
