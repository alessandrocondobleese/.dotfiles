return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    require "alessandro.plugins-configurations.telescope"
  end,
}
