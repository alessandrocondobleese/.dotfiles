local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate"
}

function M.build()
  require("nvim-treesitter.install").update({ with_sync = true })()
end

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "typescript", "markdown" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  })
end

return M
