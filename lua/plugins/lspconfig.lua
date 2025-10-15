return {
  'neovim/nvim-lspconfig',
  config = function()
    vim.lsp.config('*', {
      capabilities = vim.lsp.protocol.make_client_capabilities(),
    })
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local opts = { noremap = true, silent = true }

        -- Declare functions for mapping in current buffer
        local function map(mode, keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set(mode, keys, func, { noremap = true, silent = true, buffer = ev.buf, desc = desc })
        end

        -- NOTE: handled by keymaps.lua
        -- map("K", vim.lsp.buf.hover, "Hover Documentation")
        -- map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- LSP Goto functions prefixed with 'g'
        map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('n', 'gd', function()
          require('telescope.builtin').lsp_definitions()
        end, '[G]oto [D]efinition')
        map('n', 'gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        -- nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
        -- TODO: figure out why overwriting the handler doesn't work
        map('n', 'gr', function()
          require('telescope.builtin').lsp_references()
        end, '[G]oto [R]eferences')
        map('n', 'gI', vim.lsp.buf.incoming_calls, '[G]oto [I]ncoming Calls')
        map('n', 'gO', vim.lsp.buf.outgoing_calls, '[G]oto [O]utgoing Calls')
        map('n', '<leader>fs', vim.lsp.buf.document_symbol, '[G]oto Document [S]ymbol')
        map('n', 'gS', vim.lsp.buf.workspace_symbol, '[G]oto [W]orkspace [S]ymbol')

        -- LSP <leader> prefixed commands

        map('n', '<leader>fe', function()
          require('telescope.builtin').diagnostics { severity = 'error' }
        end, '[G]oto [E]rror')
        map('n', '<leader>fw', function()
          require('telescope.builtin').diagnostics { severity = 'warn' }
        end, '[G]oto [W]arning')

        map('n', ']d', '<cmd>lua vim.diagnostic.goto_next({})<CR>', 'Next [D]iagnostic')
        map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({})<CR>', 'Previous [D]iagnostic')
        -- nmap("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")

        map('n', ']e', '<cmd>lua vim.diagnostic.goto_next({ severity = "error" })<CR>', 'Next [E]rror')
        map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({ severity = "error" })<CR>', 'Previous [E]rror')
        map('n', ']w', '<cmd>lua vim.diagnostic.goto_next({ severity = "warn" })<CR>', 'Next [W]arning')
        map('n', '[w', '<cmd>lua vim.diagnostic.goto_prev({ severity = "warn" })<CR>', 'Previous [W]arning')

        -- Lsp keymaps
        map('n', '<leader>lr', '<cmd>LspRestart<CR>', '[L]SP [R]estart')

        -- -- Client specific maps
        -- if client.name == 'rust-analyzer' then
        --   map('n', '<leader>m', function()
        --     vim.cmd.RustLsp 'expandMacro'
        --   end, 'Expand [M]acro')
        --   map('n', '<leader>rod', function()
        --     vim.cmd.RustLsp 'externalDocs'
        --   end, '[R]ust [O]pen External [D]ocs')
        --   map('n', '<leader>e', function()
        --     vim.cmd.RustLsp 'explainError'
        --   end, 'Explain [E]rror')
        -- end
        -- if client.name == 'texlab' then
        --   map('n', '<leader>tb', '<CMD>TexlabBuild<CR>', '[T]ex [B]uild')
        --   map('n', '<leader>tf', '<CMD>TexlabForward<CR>', '[T]exlab [F]orward')
        -- end
      end,
    })

    -- Setup lsp stuff: --
    local icons = require 'config.icons'
    for name, icon in pairs(icons.diagnostics) do
      name = 'DiagnosticSign' .. name
      vim.fn.sign_define(name, { texthl = name, text = icon, numhl = '' })
    end
    -- enable inlay hint
    vim.lsp.inlay_hint.enable(true, { 0 })
    -- Config diagnostics
    vim.diagnostic.config {
      -- show signs
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
          [vim.diagnostic.severity.INFO] = icons.diagnostics.Hint,
          [vim.diagnostic.severity.HINT] = icons.diagnostics.Info,
        },
        texthl = {
          [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
          [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
          [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
          [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
        },
        -- TODO: fix priority mixup
        priority = 12, -- Is 8 so that errors can overwrite debug breakpoints
      },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      virtual_text = {
        severity = vim.diagnostic.severity.ERROR,
      },
      float = {
        focusable = false,
        style = 'minimal',
        border = 'none',
        source = 'always',
        header = '',
        prefix = '',
      },
    }

    -- Diagnostics window:
    vim.o.updatetime = 250
    vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focusable = false})]]
    -- Configure hover window NOTE: Gets overriden by noice.nvim
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {})
    -- Configure Telescope for lsp handlers
    vim.lsp.handlers['textDocument/references'] = require('telescope.builtin').lsp_references
    vim.lsp.handlers['textDocument/definition'] = require('telescope.builtin').lsp_definitions
    vim.lsp.handlers['textDocument/implementation'] = require('telescope.builtin').lsp_implementations
    vim.lsp.handlers['textDocument/documentSymbol'] = require('telescope.builtin').lsp_document_symbols
    vim.lsp.handlers['textDocument/typeDefinition'] = require('telescope.builtin').lsp_type_definitions
    vim.lsp.handlers['callHierarchy/incomingCalls'] = require('telescope.builtin').lsp_incoming_calls
    vim.lsp.handlers['callHierarchy/outgoingCalls'] = require('telescope.builtin').lsp_outgoing_calls
    vim.lsp.handlers['textDocument/documentSymbol'] = require('telescope.builtin').lsp_document_symbols
    vim.lsp.handlers['workspace/symbol'] = require('telescope.builtin').lsp_dynamic_workspace_symbols
  end,
}
