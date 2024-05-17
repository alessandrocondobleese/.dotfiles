local completion = require "cmp"
local luasnip = require "luasnip"

completion.setup {
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
  },

  mapping = {
    ["<C-n>"] = completion.mapping.select_next_item { behavior = completion.SelectBehavior.Insert },
    ["<C-p>"] = completion.mapping.select_prev_item { behavior = completion.SelectBehavior.Insert },
    ["<C-y>"] = completion.mapping(
      completion.mapping.confirm {
        behavior = completion.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
  },
  -- Enable luasnip to handle snippet expansion for nvim-completion
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
}

local lspkind = require "lspkind"
lspkind.init {}

luasnip.config.set_config {
  history = false,
  updateevents = "TextChanged,TextChangedI",
}

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })
