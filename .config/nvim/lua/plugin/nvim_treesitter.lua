local languages = { "c", "lua", "javascript", "typescript", "python", "regex" }
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = function()
    -- replicate `ensure_installed`, runs asynchronously, skips languages that have
    -- already been installed, however ONLY occurs when the build is triggered
    -- if you want to install any missing parsers on startup then you'd need to move
    -- this into the config section, however that will echo output on every run
    -- the plugin calls a few more APIs to figure out which languages are missing and
    -- only calls install when there are uninstalled languages, which prevents output
    require("nvim-treesitter").install(languages)
    require("nvim-treesitter").update()
  end,
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter.setup", {}),
      callback = function(args)
        local buffer = args.buf
        local filetype = args.match

        -- you need some mechanism to avoid running on buffers that do not
        -- correspond to a language (like oil.nvim buffers), this implementation
        -- checks if a parser exists for the current language
        local language = vim.treesitter.language.get_lang(filetype) or filetype
        if not vim.treesitter.language.add(language) then
          return
        end

        -- replicate `highlight = { enable = true }`
        vim.treesitter.start(buffer, language)

        -- replicate `indent = { enable = true }`
        vim.bo[buffer].indentexpr =
          "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
