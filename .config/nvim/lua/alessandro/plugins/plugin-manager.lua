local M = {}

M.setup = function()
  local lazy_path_hash = "/lazy/lazy.nvim"
  local lazy_path = vim.fn.stdpath("data") .. lazy_path_hash
  local lazy_exists = vim.loop.fs_stat(lazy_path)
  if not lazy_exists then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazy_path,
    })
  end
  vim.opt.rtp:prepend(lazy_path)

  require("lazy").setup("alessandro/plugins/plugins-configurations", {
    change_detection = {
      enabled = true,
      notify = false,
    }
  })
end

return M
