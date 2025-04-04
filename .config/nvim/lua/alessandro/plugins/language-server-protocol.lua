return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    -- NVIM local development
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
    --
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- Autoformatting
    "stevearc/conform.nvim",
    -- JSON Schema information
    "b0o/SchemaStore.nvim",

    "saghen/blink.cmp",
  },
  config = function()
    local lspconfig = require "lspconfig"
    local servers = {
      ruff = true,
      pyright = true,
      ts_ls = true,
      bashls = true,
      lua_ls = true,
      jsonls = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },
      clangd = true,
    }

    local servers_to_install = vim.tbl_filter(function(key)
      return servers[key]
    end, vim.tbl_keys(servers))

    require("mason").setup()
    local ensure_installed = {
      "stylua",
      "lua_ls",
    }

    vim.list_extend(ensure_installed, servers_to_install)
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }
    for name, config in pairs(servers) do
      if config == true then
        config = {}
      end

      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      lspconfig[name].setup(config)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

        vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
      end,
    })
    -- Autoformatting Setup
    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_lsp" },
      },
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        require("conform").format {
          bufnr = args.buf,
          lsp_fallback = true,
          quiet = true,
        }
      end,
    })

    vim.diagnostic.config { virtual_lines = true }
  end,
}
