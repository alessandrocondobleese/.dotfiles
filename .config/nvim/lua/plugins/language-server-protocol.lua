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

local function async_format(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	vim.lsp.buf_request(
		bufnr,
		"textDocument/formatting",
		vim.lsp.util.make_formatting_params({}),
		function(err, res, ctx)
			if err then
				local err_msg = type(err) == "string" and err or err.message
				-- you can modify the log message / level (or ignore it completely)
				vim.notify("Formatting: " .. err_msg, vim.log.levels.WARN)
				return
			end

			-- don't apply results if buffer is unloaded or has been modified
			if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
				return
			end

			if res then
				local client = vim.lsp.get_client_by_id(ctx.client_id)
				vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd("silent noautocmd update")
				end)
			end
		end
	)
end

local signs = {
	DiagnosticSignError = "",
	DiagnosticSignWarn = "",
	DiagnosticSignHint = "",
	DiagnosticSignInfo = "",
}

function language_server_protocol.config_diagnostics_signs()
	for sign_name, sign in pairs(signs) do
		vim.fn.sign_define(sign_name, {
			text = sign,
			texthl = sign_name,
			numhl = sign_name,
		})
	end
end

function language_server_protocol.config()
	require("neodev").setup()

	local lsp = require("lsp-zero")
	lsp.preset("recommended")
	lsp.setup_nvim_cmp({
		sources = {
			{ name = "nvim_lsp", keyword_length = 1 },
		},
	})
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
						async_format(bufnr)
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
				desc = "Formatting",
			})
		end,
	})

	require("mason-null-ls").setup({
		ensure_installed = nil,
		automatic_installation = false,
		automatic_setup = true,
	})

	require("mason-null-ls").setup_handlers({})

	language_server_protocol.config_diagnostics_signs()
end

return language_server_protocol
