local pair = {
	"windwp/nvim-autopairs",
}

function pair.config()
	require("nvim-autopairs").setup({
		check_ts = true,
	})
end

return pair
