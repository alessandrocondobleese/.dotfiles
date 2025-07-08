return {
  {
    'mason-org/mason.nvim',
    dependencies = {
      'mason-org/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },
    lazy = false,
    --- Sets up Mason and Mason-LSPConfig.
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = { 'lua_ls' },
      }

      vim.diagnostic.config { virtual_lines = true }
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

      ---@param event table The LspAttach event table.
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
          vim.keymap.set(
            'n',
            'gd',
            vim.lsp.buf.definition,
            { buffer = event.buf }
          )
          vim.keymap.set(
            'n',
            'gr',
            vim.lsp.buf.references,
            { buffer = event.buf }
          )
          vim.keymap.set(
            'n',
            'gD',
            vim.lsp.buf.declaration,
            { buffer = event.buf }
          )
          vim.keymap.set(
            'n',
            'gT',
            vim.lsp.buf.type_definition,
            { buffer = event.buf }
          )
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = event.buf })

          vim.keymap.set(
            'n',
            '<leader>cr',
            vim.lsp.buf.rename,
            { buffer = event.buf }
          )
          vim.keymap.set(
            'n',
            '<leader>ca',
            vim.lsp.buf.code_action,
            { buffer = event.buf }
          )
        end,
      })
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    ---@type LazydevOpts
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    --- Sets up symbol-usage.nvim.
    config = function()
      require('symbol-usage').setup {
        references = { enabled = true, include_declaration = true },
        implementation = { enabled = false },
        log = { enabled = false },
        --- Formats the text for symbol usage display.
        ---@param symbol table The symbol data.
        ---@return table A table containing formatted text and highlight group.
        text_format = function(symbol_data)
          local result = {}

          if symbol_data.references then
            local usage_text = symbol_data.references == 1 and 'reference'
              or 'references'
            table.insert(result, {
              ('󰌹  %s %s'):format(symbol_data.references, usage_text),
              'LspCodeLens',
            })
          end

          return result
        end,
      }
    end,
  },
}
