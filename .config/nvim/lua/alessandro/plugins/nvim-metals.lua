return {
  "scalameta/nvim-metals",
  dependencies = {
    { "j-hui/fidget.nvim", opts = {} },
    { "nvim-lua/plenary.nvim" },
  },
  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals = require "metals"
    local configuration = metals.bare_config()

    configuration.init_options.statusBarProvider = "off"
    configuration.capabilities = require("cmp_nvim_lsp").default_capabilities()

    configuration.on_attach = function(client, bufnr)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition)
      vim.keymap.set("n", "K", vim.lsp.buf.hover)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
      vim.keymap.set("n", "gr", vim.lsp.buf.references)
      vim.keymap.set("n", "gds", vim.lsp.buf.document_symbol)
      vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
      vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run)
      vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help)
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
    end

    return configuration
  end,
  config = function(self, configuration)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(configuration)
      end,
      group = nvim_metals_group,
    })
  end,
}
