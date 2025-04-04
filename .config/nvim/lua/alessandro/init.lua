local plugin_manager = require "alessandro.plugin-manager"

vim.g.mapleader = " "

plugin_manager.config()

require "alessandro.globals"
require "alessandro.ui"
