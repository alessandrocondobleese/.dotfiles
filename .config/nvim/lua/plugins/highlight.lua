local highlight = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
}

function highlight.config()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "c", "lua", "vim", "help", "bash", "css", "html", "javascript", "typescript" },
		indent = {
			enable = true,
		},
	})
end

return highlight
