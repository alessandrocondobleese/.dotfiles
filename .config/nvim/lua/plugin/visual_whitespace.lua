return {
	"mcauley-penney/visual-whitespace.nvim",
	config = true,
	event = "ModeChanged *:[vV\22]",
	opts = {
		fileformat_chars = {
			unix = "¬",
		},
	},
}
