local language_server_protocol = {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v1.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" }, -- Required
		{ "williamboman/mason.nvim" }, -- Optional
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" }, -- Required
		{ "hrsh7th/cmp-nvim-lsp" }, -- Required
		{ "hrsh7th/cmp-buffer" }, -- Optional
		{ "hrsh7th/cmp-path" }, -- Optional
		{ "saadparwaiz1/cmp_luasnip" }, -- Optional
		{ "hrsh7th/cmp-nvim-lua" }, -- Optional

		-- Snippets
		{ "L3MON4D3/LuaSnip" }, -- Required
		{ "rafamadriz/friendly-snippets" }, -- Optional

		-- For neovim development
		{ "folke/neodev.nvim" },

		-- Nullls
		{ "jose-elias-alvarez/null-ls.nvim" },
		{ "jay-babu/mason-null-ls.nvim" },
		{ "nvim-lua/plenary.nvim" },
	},
}

function language_server_protocol.config()
	require("neodev").setup()

	local lsp = require("lsp-zero")
	lsp.preset("recommended")
	lsp.ensure_installed({
		"html",
		"cssls",
		"tsserver",
		"sumneko_lua",
	})
	lsp.nvim_workspace()
	lsp.setup()

	local null = require("null-ls")
	local null_options = lsp.build_options("null-ls", {})
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	null.setup({
		sources = {
			null.builtins.code_actions.eslint,
			null.builtins.completion.spell,
		},
		on_attach = function(client, bufnr)
			null_options.on_attach(client, bufnr)

			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end

			local format_command_callback = function(input)
				vim.lsp.buf.format({
					id = client.id,
					timeout_ms = 5000,
					async = input.bang,
				})
			end

			local bufcmd = vim.api.nvim_buf_create_user_command
			bufcmd(bufnr, "NullFormat", format_command_callback, {
				bang = true,
				range = true,
				desc = "Format using null-ls",
			})
		end,
	})

	require("mason-null-ls").setup({
		ensure_installed = nil,
		automatic_installation = false,
		automatic_setup = true,
	})

	require("mason-null-ls").setup_handlers({})
end

return language_server_protocol
