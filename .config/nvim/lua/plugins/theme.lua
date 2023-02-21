local theme = {
  "JoosepAlviste/palenightfall.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "yamatsum/nvim-nonicons",
    { "AlexvZyl/nordic.nvim" },
    { "navarasu/onedark.nvim" },
  },
}

function theme.palenightfall()
  local highlight = require("palenightfall.internal").highlight
  local colors = require("palenightfall").colors
  require("palenightfall").setup({
    highlight_overrides = {
      StatuslineAccent = { fg = colors.cyan, bg = colors.statusline },
      StatuslineBoolean = { fg = colors.orange, bg = colors.statusline },
      StatuslineError = { fg = colors.red, bg = colors.statusline },
      StatuslineWarning = { fg = colors.orange, bg = colors.statusline },
      StatuslineSuccess = { fg = colors.green, bg = colors.statusline },
      StatuslinePending = { fg = colors.yellow, bg = colors.statusline },
      StatuslineNormal = { fg = colors.cyan, bg = colors.statusline },
      StatuslineInsert = { fg = colors.green, bg = colors.statusline },
      StatuslineReplace = { fg = colors.orange, bg = colors.statusline },
      StatuslineVisual = { fg = colors.purple, bg = colors.statusline },
      StatuslineCommand = { fg = colors.yellow, bg = colors.statusline },
      StatuslineBlue = { fg = colors.blue, bg = colors.statusline },
    },
  })

  local icons = require("nvim-web-devicons").get_icons()
  for _, icon_data in pairs(icons) do
    if icon_data.color and icon_data.name then
      local hl_group = icon_data.name and "StatuslineDevIcon" .. icon_data.name
      if hl_group then
        highlight(hl_group, { fg = icon_data.color, bg = colors.statusline })
      end
    end
  end
end

function theme.nordic()
  require("nordic").setup({
    -- theme = 'onedark',
    telescope = {
      -- Available styles: `classic`, `flat`.
      style = "flat",
    },
    -- Enable bold keywords and operators.
    bold_keywords = false,
    -- Enable italicized comments.
    italic_comments = true,
    -- Enable general editor background transparency.
    transparent_bg = false,
    -- Override styling of any highlight group.
    -- (see next section for an example)
    override = {},
    cursorline = {
      bold = false,
      -- Avialable styles: 'dark', 'light'.
      theme = "light",
    },
    noice = {
      style = "classic",
    },
    onedark = {
      -- Brighten the whites to fit the theme better.
      brighter_whites = true,
    },
  })

  vim.cmd.colorscheme("nordic")
end

function theme.onedark()
  require("onedark").setup({
    style = "darker",
  })
end

function theme.config()
  theme.onedark()
  theme.nordic()
  require("nvim-web-devicons").setup()
  require("nvim-nonicons").setup()
end

return theme
