local shared = {}

function shared.code(code)
	return vim.api.nvim_replace_termcodes(code, true, true, true)
end

return shared
