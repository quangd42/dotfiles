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
      'saghen/blink.cmp', -- 'hrsh7th/cmp-nvim-lsp',

      -- IncRename
      { 'smjonas/inc-rename.nvim', cmd = 'IncRename', opts = {} },
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

          -- stylua: ignore start
          map('gd', function() Snacks.picker.lsp_definitions() end, 'Goto Definition') --  To jump back, press <C-t>.
          map('gr', function() Snacks.picker.lsp_references() end, 'Goto References')
          map('gI', function() Snacks.picker.lsp_implementations() end, 'Goto Implementation')
          map('gy', function() Snacks.picker.lsp_type_definitions() end, 'Goto Type Definition')
          map('<leader>ss', function() Snacks.picker.lsp_symbols() end, 'Document Symbols')
          map('<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, 'Workspace Symbols')
          -- stylua: ignore end
          vim.keymap.set('n', '<leader>cr', function()
            local inc_rename = require 'inc_rename'
            return ':' .. inc_rename.config.cmd_name .. ' ' .. vim.fn.expand '<cword>'
          end, { expr = true, desc = 'Rename Symbol (inc-rename)' })
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
          map('<leader>cd', function()
            return require('flash').jump {
              matcher = function(win)
                ---@param diag vim.Diagnostic
                return vim.tbl_map(function(diag)
                  return {
                    pos = { diag.lnum + 1, diag.col },
                    end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
                  }
                end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
              end,
              action = function(match, state)
                vim.api.nvim_win_call(match.win, function()
                  vim.api.nvim_win_set_cursor(match.win, match.pos)
                  vim.diagnostic.open_float()
                end)
                state:restore()
              end,
            }
          end, 'View Diagnostics')
          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
          map('gK', vim.lsp.buf.signature_help, 'Signature Help')
          map('<c-k>', vim.lsp.buf.signature_help, 'Signature Help', 'i')

          map('<leader>cl', ':LspInfo<cr>', 'Lsp Info')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then
            return
          end
          -- Highlight the references of word under cursor
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

          -- Language specifics that need to be called on LspAttach
          if opts.setup[client.name] then
            opts.setup[client.name](client)
          end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      local signs = { ERROR = ' ', WARN = ' ', HINT = ' ', INFO = ' ' }
      local diagnostic_signs = {}
      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end
      vim.diagnostic.config { signs = { text = diagnostic_signs }, float = { source = true } }

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
