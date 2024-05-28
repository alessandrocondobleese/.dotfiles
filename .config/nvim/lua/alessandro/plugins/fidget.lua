return {
  "j-hui/fidget.nvim",
  opts = {},
  config = function()
    local fidget = require "fidget"
    fidget.setup {
      progress = {
        display = {
          done_icon = "󰄬",
          progress_icon = { "arc" },
        },
      },
    }
  end,
}
