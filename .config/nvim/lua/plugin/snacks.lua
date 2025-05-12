return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		picker = {
			icons = {
				file = {
					enabled = false,
				},
			},
		},
	},
	keys = {
		-- Top Pickers & Explorer
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		-- GIT
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
	},
}
