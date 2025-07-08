--- Gets the LSP completion context based on the source name.
---@param completion table The completion item.
---@return string|nil The completion context string or nil.
local function get_lsp_completion_context(completion_item)
  local status_ok, source_name = pcall(function()
    return vim.lsp.get_client_by_id(completion_item.client_id).name
  end)
  if not status_ok then
    return nil
  end

  if source_name == 'ts_ls' then
    return completion_item.detail
  elseif source_name == 'pyright' and completion_item.labelDetails ~= nil then
    return completion_item.labelDetails.description
  elseif source_name == 'texlab' then
    return completion_item.detail
  elseif source_name == 'clangd' then
    local documentation = completion_item.documentation
    if documentation == nil then
      return
    end

    local import_string = documentation.value
    import_string = import_string:gsub('[\n]+', '')

    local matched_string
    matched_string = import_string:match '<(.-)>'
    if matched_string then
      return '<' .. matched_string .. '>'
    end

    matched_string = import_string:match '["\'](.-)["\']'
    if matched_string then
      return '"' .. matched_string .. '"'
    end

    return nil
  end
end

return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'echasnovski/mini.snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {

    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    snippets = { preset = 'mini_snippets' },
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
      kind_icons = {
        Array = ' 󰅪 ',
        BlockMappingPair = ' 󰅩  ',
        Boolean = '   ',
        BreakStatement = ' 󰙧  ',
        Call = ' 󰃷 ',
        CaseStatement = ' 󱃙  ',
        Class = '   ',
        Color = '   ',
        Constant = '   ',
        Constructor = ' 󰆦  ',
        ContinueStatement = ' → ',
        Copilot = '   ',
        Declaration = ' 󰙠  ',
        Delete = ' 󰩺 ',
        DoStatement = ' 󰑖 ',
        Element = ' 󰅩  ',
        Enum = '  ',
        EnumMember = '  ',
        Event = ' ',
        Field = '   ',
        File = '  ',
        Folder = '  ',
        ForStatement = '󰑖 ',
        Function = ' 󰆦  ',
        GotoStatement = ' 󰁔 ',
        Identifier = ' 󰀫 ',
        IfStatement = ' 󰇉  ',
        Interface = '   ',
        Keyword = '   ',
        List = ' 󰅪 ',
        Log = ' 󰦪 ',
        Lsp = '   ',
        Macro = ' 󰁌  ',
        MarkdownH1 = ' 󰉫 ',
        MarkdownH2 = ' 󰉬 ',
        MarkdownH3 = ' 󰉭 ',
        MarkdownH4 = ' 󰉮 ',
        MarkdownH5 = ' 󰉯 ',
        MarkdownH6 = ' 󰉰 ',
        Method = ' 󰆦  ',
        Module = '   ',
        Namespace = ' 󰅩  ',
        Null = ' 󰢤  ',
        Number = ' 󰎠  ',
        Object = ' 󰅩  ',
        Operator = '   ',
        Package = ' 󰆦  ',
        Pair = ' 󰅪 ',
        Property = '   ',
        Reference = '   ',
        Regex = '  ',
        Repeat = ' 󰑖 ',
        Return = ' 󰌑  ',
        RuleSet = ' 󰅩  ',
        Scope = ' 󰅩  ',
        Section = ' 󰅩  ',
        Snippet = '   ',
        Specifier = ' 󰦪 ',
        Statement = ' 󰅩  ',
        String = '   ',
        Struct = '   ',
        SwitchStatement = '󰺟  ',
        Table = ' 󰅩  ',
        Terminal = '  ',
        Text = '   ',
        Type = '  ',
        TypeParameter = '   ',
        Unit = '  ',
        Value = '   ',
        Variable = '   ',
        WhileStatement = ' 󰑖  ',
      },
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      trigger = {
        show_on_backspace = true,
        show_on_trigger_character = true,
      },
      keyword = {
        range = 'full',
      },
      list = {
        selection = { preselect = true, auto_insert = false },
        cycle = { from_top = false },
      },
      documentation = {
        window = {
          border = 'solid',
          min_width = 40,
          max_width = 70,
        },
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      menu = {
        min_width = 34,
        max_height = 10,
        draw = {
          treesitter = { 'lsp' },
          align_to = 'cursor',
          padding = 1,
          gap = 3,
          columns = {
            { 'kind_icon', gap = 0, 'label' },
            { 'label_description' },
          },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(context_data)
                return context_data.kind_icon .. ' '
              end,
              highlight = function(context_data)
                return 'BlinkCmpKind' .. context_data.kind
              end,
            },
            label = {
              width = {
                fill = true,
                max = 60,
              },
              text = function(context_data)
                return context_data.label .. context_data.label_detail
              end,
              highlight = function(context_data)
                local highlights = {
                  {
                    0,
                    #context_data.label,
                    group = context_data.deprecated
                        and 'BlinkCmpLabelDeprecated'
                      or 'BlinkCmpLabel',
                  },
                }
                if context_data.label_detail then
                  table.insert(highlights, {
                    #context_data.label,
                    #context_data.label + #context_data.label_detail,
                    group = 'BlinkCmpLabelDetail',
                  })
                end

                for _, index in ipairs(context_data.label_matched_indices) do
                  table.insert(
                    highlights,
                    { index, index + 1, group = 'BlinkCmpLabelMatch' }
                  )
                end

                return highlights
              end,
            },
            label_description = {
              text = function(context_data)
                return get_lsp_completion_context(context_data.item)
              end,
              highlight = 'BlinkCmpLabelDescription',
            },
          },
        },
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
