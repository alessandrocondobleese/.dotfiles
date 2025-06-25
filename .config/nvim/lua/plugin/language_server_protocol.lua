return {
  {
    "mason-org/mason.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    lazy = false,
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })

      vim.diagnostic.config({ virtual_lines = true })
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function()
          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            { buffer = 0 }
          )
        end,
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      require("symbol-usage").setup({
        references = { enabled = true, include_declaration = true },
        implementation = { enabled = false },
        log = { enabled = false },
        text_format = function(symbol)
          local res = {}

          if symbol.references then
            local usage = symbol.references == 1 and "reference" or "references"
            table.insert(res, {
              ("󰌹  %s %s"):format(symbol.references, usage),
              "LspCodeLens",
            })
          end

          return res
        end,
      })
    end,
  },
}
