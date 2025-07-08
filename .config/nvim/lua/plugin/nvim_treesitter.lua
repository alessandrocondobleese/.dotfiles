local enabled_languages =
  { 'c', 'lua', 'javascript', 'typescript', 'python', 'regex' }
---@type TreesitterConfig
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  --- Builds and installs Tree-sitter parsers.
  build = function()
    -- replicate `ensure_installed`, runs asynchronously, skips languages that have
    -- already been installed, however ONLY occurs when the build is triggered
    -- if you want to install any missing parsers on startup then you'd need to move
    -- this into the config section, however that will echo output on every run
    -- the plugin calls a few more APIs to figure out which languages are missing and
    -- only calls install when there are uninstalled languages, which prevents output
    require('nvim-treesitter').install(enabled_languages)
    require('nvim-treesitter').update()
  end,
  --- Configures Tree-sitter for syntax highlighting and indentation.
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter.setup', {}),
      ---@param event_arguments table The autocmd event arguments.
      callback = function(event_arguments)
        local current_buffer = event_arguments.buf
        local current_filetype = event_arguments.match

        -- you need some mechanism to avoid running on buffers that do not
        -- correspond to a language (like oil.nvim buffers), this implementation
        -- checks if a parser exists for the current language
        local parser_language = vim.treesitter.language.get_lang(
          current_filetype
        ) or current_filetype
        if not vim.treesitter.language.add(parser_language) then
          return
        end

        -- replicate `highlight = { enable = true }`
        vim.treesitter.start(current_buffer, parser_language)

        -- replicate `indent = { enable = true }`
        vim.bo[current_buffer].indentexpr =
          "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
