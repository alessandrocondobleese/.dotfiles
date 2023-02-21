local highlight = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
    { "RRethy/vim-illuminate" },
    { "lukas-reineke/indent-blankline.nvim" },
  },
}

function highlight.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "vim", "help", "bash", "css", "html", "javascript", "typescript" },
    indent = {
      enable = true,
    },
  })

  require("illuminate").configure({
    under_cursor = true,
    delay = 100,
    filetypes_denylist = {
      "startify",
      "NvimTree",
    },
  })

  require("indent_blankline").setup({
    show_end_of_line = true,
    show_current_context = true,
    show_current_context_start = false,
    filetype_exclude = { "NvimTree", "startify", "dashboard" },
    use_treesitter = false,
    use_treesitter_scope = false,
    context_char = "│",
    char = "┆",
  })

  vim.diagnostic.config({
    virtual_text = false,
  })

  require("lsp_lines").setup()
end

return highlight
