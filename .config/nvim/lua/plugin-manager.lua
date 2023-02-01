local plugin_manager = {
	path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
}

function plugin_manager.setup()
	plugin_manager.install()
	plugin_manager.configuration()
end

function plugin_manager.configuration()
	require("lazy").setup("plugins")
end

function plugin_manager.install()
	if not vim.loop.fs_stat(plugin_manager.path) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			plugin_manager.path,
		})
	end
	vim.opt.rtp:prepend(plugin_manager.path)
end

plugin_manager.setup()

return plugin_manager
