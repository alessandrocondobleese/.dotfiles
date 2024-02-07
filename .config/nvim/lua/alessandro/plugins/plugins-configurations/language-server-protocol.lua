local M = {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
  }
}

function M.config()
  local lsp_zero = require('lsp-zero')

  lsp_zero.on_attach(function(client, buffer)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = buffer })
    lsp_zero.buffer_autoformat()

    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = buffer })
  end)

  local cmp = require('cmp')
  local cmp_action = require('lsp-zero').cmp_action()

  cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<Tab>'] = cmp_action.luasnip_supertab(),
      ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    })
  })

  require('mason').setup({})
  require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
      lsp_zero.default_setup,
    },
  })
end

return M
