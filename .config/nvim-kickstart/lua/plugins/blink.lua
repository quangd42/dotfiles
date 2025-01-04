return {
  { 'hrsh7th/nvim-cmp', enabled = false },
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      -- to add luasnip look at https://cmp.saghen.dev/configuration/snippets.html#luasnip
      -- { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },

    -- use a release tag to download pre-built binaries
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        -- show with a list of providers
        ['<C-space>'] = {
          function(cmp)
            cmp.show { providers = { 'copilot' } }
          end,
        },
        cmdline = {
          preset = 'none',
          ['<S-Tab>'] = { 'select_prev', 'fallback' },
          ['<Tab>'] = { 'select_next', 'fallback' },
          ['<Up>'] = { 'select_prev', 'fallback' },
          ['<Down>'] = { 'select_next', 'fallback' },
          ['<C-p>'] = { 'select_prev', 'fallback' },
          ['<C-n>'] = { 'select_next', 'fallback' },
        },
      },

      appearance = {
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
        -- Custom icons, for now must copy paste the entire set
        kind_icons = {
          Copilot = '',
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',

          Field = '󰜢',
          Variable = '󰆦',
          Property = '󰖷',

          Class = '󱡠',
          Interface = '󱡠',
          Struct = '󱡠',
          Module = '󰅩',

          Unit = '󰪚',
          Value = '󰦨',
          Enum = '󰦨',
          EnumMember = '󰦨',

          Keyword = '󰻾',
          Constant = '󰏿',

          Snippet = '󱄽',
          Color = '󰏘',
          File = '󰈔',
          Reference = '󰬲',
          Folder = '󰉋',
          Event = '󱐋',
          Operator = '󰪚',
          TypeParameter = '󰬛',
        },
      },

      completion = {
        menu = {
          -- nvim-cmp style menu
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind', gap = 1 },
            },
            treesitter = { 'lsp' },
          },
        },
        -- auto_insert for cmdline
        list = {
          selection = function(ctx)
            return ctx.mode == 'cmdline' and 'auto_insert' or 'preselect'
          end,
        },
        -- Show documentation when selecting a completion item
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            min_width = 10,
            max_width = 120,
            max_height = 40,
          },
        },

        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = true },
      },

      -- Experimental signature help support
      signature = { enabled = true },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
    opts_extend = { 'sources.default' },
  },

  -- LazyDev source
  {
    'saghen/blink.cmp',
    optional = true,
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { 'lazydev' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100, -- show at a higher priority than lsp
          },
        },
      },
    },
  },

  -- Copilot source
  {
    'saghen/blink.cmp',
    optional = true,
    dependencies = {
      {
        'giuxtaposition/blink-cmp-copilot',
        dependencies = {
          'zbirenbaum/copilot.lua',
          opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
          },
        },
      },
    },
    opts = {
      sources = {
        -- default = { 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = 'Copilot'
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
          },
        },
      },
    },
  },
}
