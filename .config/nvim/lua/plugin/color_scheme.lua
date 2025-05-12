return {
	"mcauley-penney/phobos-anomaly.nvim",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("phobos-anomaly")
		vim.api.nvim_set_hl(0, "VisualNonText", { fg = "#5D5F71", bg = "#24282d" })
	end,
}
