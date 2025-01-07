-- LSP Plugins
return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    cmd = 'LazyDev',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },

  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp / blink
      -- 'hrsh7th/cmp-nvim-lsp',
      'saghen/blink.cmp',
    },
    config = function(_, opts)
      local function augroup(name)
        return vim.api.nvim_create_augroup('my-' .. name, { clear = true })
      end
      vim.api.nvim_create_autocmd('LspAttach', {
        group = augroup 'lsp-attach',
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition') --  To jump back, press <C-t>.
          map('gr', require('telescope.builtin').lsp_references, 'Goto References')
          map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
          map('gy', require('telescope.builtin').lsp_type_definitions, 'Goto Type Definition')
          map('<leader>ss', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
          map('<leader>sS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
          map('<leader>cr', vim.lsp.buf.rename, 'Rename Symbol')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
          map('<leader>cd', vim.diagnostic.open_float, 'View Diagnostics')
          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
          map('gK', vim.lsp.buf.signature_help, 'Signature Help')
          map('<c-k>', vim.lsp.buf.signature_help, 'Signature Help', 'i')

          map('<leader>cl', ':LspInfo<cr>', 'Lsp Info')

          -- Highlight the references of word under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then
            return
          end
          if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = augroup 'lsp-highlight'
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = augroup 'lsp-detach',
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'my-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Toggle Inlay hints
          if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>uh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay Hints')
          end

          -- Language specifics
          if opts.setup[client.name] then
            opts.setup[client.name](client)
          end
          -- Go
          -- if client.name == 'gopls' and not client.server_capabilities.semanticTokensProvider then
          --   local semantic = client.config.capabilities.textDocument.semanticTokens
          --   client.server_capabilities.semanticTokensProvider = {
          --     full = true,
          --     ---@diagnostic disable-next-line: need-check-nil
          --     legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
          --     range = true,
          --   }
          -- end

          -- Python
          -- if client.name == 'ruff' then
          --   -- Disable hover in favor of Pyright
          --   client.server_capabilities.hoverProvider = false
          -- end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      local signs = { ERROR = ' ', WARN = ' ', HINT = ' ', INFO = ' ' }
      local diagnostic_signs = {}
      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end
      vim.diagnostic.config { signs = { text = diagnostic_signs } }

      -- Add capabilities to what Neovim can support from LSP servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

      -- Enable the following language servers
      local servers = opts.servers or {}
      servers.lua_ls = {
        -- https://luals.github.io/wiki/settings/
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- Ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { 'missing-fields' } },
          },
        },

        -- gopls = {
        --   settings = {
        --     gopls = {
        --       gofumpt = true,
        --       codelenses = {
        --         gc_details = false,
        --         generate = true,
        --         regenerate_cgo = true,
        --         run_govulncheck = true,
        --         test = true,
        --         tidy = true,
        --         upgrade_dependency = true,
        --         vendor = true,
        --       },
        --       hints = {
        --         -- assignVariableTypes = true,
        --         -- compositeLiteralFields = true,
        --         -- compositeLiteralTypes = true,
        --         constantValues = true,
        --         -- functionTypeParameters = true,
        --         -- parameterNames = true,
        --         rangeVariableTypes = true,
        --       },
        --       analyses = {
        --         -- fieldalignment = true,
        --         nilness = true,
        --         unusedparams = true,
        --         unusedwrite = true,
        --         useany = true,
        --       },
        --       usePlaceholders = true,
        --       completeUnimported = true,
        --       staticcheck = true,
        --       directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
        --       semanticTokens = true,
        --     },
        --   },
        -- },

        -- Python
        -- ruff = {
        --   cmd_env = { RUFF_TRACE = 'messages' },
        --   init_options = {
        --     settings = {
        --       logLevel = 'error',
        --     },
        --   },
        -- },
        -- pyright = {
        --   settings = {
        --     pyright = {
        --       -- Using Ruff's import organizer
        --       disableOrganizeImports = true,
        --     },
        --     python = {
        --       analysis = {
        --         -- Ignore all files for analysis to exclusively use Ruff for linting
        --         ignore = { '*' },
        --       },
        --     },
        --   },
        -- },
      }

      -- Ensure the servers above are installed with Mason through mason-lspconfig
      require('mason').setup()

      require('mason-lspconfig').setup {
        automatic_installation = true,
        ensure_installed = vim.tbl_keys(servers or {}),
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  -- Mason ensure_installed, yoinked from LazyVim
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        'stylua',
        'shfmt',
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require 'mason-registry'
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger {
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          }
        end, 100)
      end)

      -- Automatically install and update everything in ensure_installed
      -- Instead of mason-tool-installer due to start up issue
      -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
      mr.refresh(function()
        for _, name in pairs(opts.ensure_installed) do
          local p = mr.get_package(name)
          if not mr.is_installed(name) then
            p:install()
          else
            p:check_new_version(function(success, result_or_err)
              if success then
                p:install { version = result_or_err.latest_version }
              end
            end)
          end
        end
      end)
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
