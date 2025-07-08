require('core.config').setup()
require('plugin_manager.plugin_manager')

local Statusline = require('components.statusline')
local statusline = Statusline:new()

vim.o.statusline = "%!v:lua.require('components.statusline').render()"