
local keymap = require("alessandro.preferences.keymap") 
local option = require("alessandro.preferences.option")
local plugin_manager = require('alessandro.plugins.plugin-manager')

keymap:setup()
option:setup()
plugin_manager:setup()
