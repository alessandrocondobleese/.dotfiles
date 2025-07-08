---@type MiniSnippetsOpts
return {
  'echasnovski/mini.snippets',
  opts = {
    snippets = {
      --  gen_loader.from_file('~/.config/nvim/snippets/global.json'),
      require('mini.snippets').gen_loader.from_lang(),
    },
    mappings = {
      stop = '<C-c>',
    },
    expand = {
      --- Inserts a snippet with custom empty tabstop behavior.
      ---@param snippet table The snippet to insert.
      ---@return string The expanded snippet string.
      insert = function(snippet_data)
        return require('mini.snippets').default_insert(snippet_data, {
          empty_tabstop = '',
          empty_tabstop_final = '*',
        })
      end,
    },
  },
  --- Sets up the mini.snippets plugin.
  ---@param _ any Unused parameter.
  ---@param plugin_options table The options for the plugin.
  configs = function(_, plugin_options)
    require('mini.snippets').setup(plugin_options)

    vim.api.nvim_set_hl(0, 'MiniSnippetsFinal', { link = 'Comment' })
  end,
}
