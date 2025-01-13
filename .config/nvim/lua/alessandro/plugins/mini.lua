return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.surround").setup()
    require("mini.cursorword").setup()
    require("mini.basics").setup()
  end,
}
