local code_actions = {
	"smjonas/inc-rename.nvim",
}

function code_actions.config()
	require("inc_rename").setup({
		cmd_name = "Rename",
	})

	vim.keymap.set("n", "<leader>rn", function()
		return ":Rename " .. vim.fn.expand("<cword>")
	end, { expr = true })
end

return code_actions
