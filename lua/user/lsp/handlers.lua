local M = {}
local icons = require "user.icons"

-- This function configures the common lsp frontend
M.setup = function()
    for name, icon in pairs(icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { texthl = name, text = icon, numhl = "" })
    end

    vim.g.code_action_menu_window_border = "rounded"

    local config = {
        -- set virtual text
        virtual_text = false,
        -- virtual_text = {
        --     severity = vim.diagnostic.severity.ERROR,
        -- },
        -- show signs
        signs = {
            priority = 8, -- Is 8 so that errors can overwrite debug breakpoints
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    -- Diagnostics window:
    vim.o.updatetime = 250
    vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focusable = false})]]

    -- Configure hover window NOTE: Gets overriden by noice.nvim
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })
    --vim.lsp.handlers["textDocument/hover"] = require('rust-tools.hover_actions').hover_actions

    -- Configure signatureHelp handlers
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            -- Enable underline, use default values
            underline = true,
            -- Disable a feature
            -- update_in_insert = false,
        })

    -- Configure Telescope for lsp handlers

    vim.lsp.handlers["textDocument/references"] = require "telescope.builtin".lsp_references

    vim.lsp.handlers["textDocument/definition"] = require "telescope.builtin".lsp_definitions

    vim.lsp.handlers["textDocument/implementation"] = require "telescope.builtin".lsp_implementations

    vim.lsp.handlers["textDocument/documentSymbol"] = require "telescope.builtin".lsp_document_symbols

    vim.lsp.handlers["textDocument/typeDefinition"] = require "telescope.builtin".lsp_type_definitions

    vim.lsp.handlers["callHierarchy/incomingCalls"] = require "telescope.builtin".lsp_incoming_calls

    vim.lsp.handlers["callHierarchy/outgoingCalls"] = require "telescope.builtin".lsp_outgoing_calls

    vim.lsp.handlers["textDocument/documentSymbol"] = require "telescope.builtin".lsp_document_symbols

    vim.lsp.handlers["workspace/symbol"] = require "telescope.builtin".lsp_dynamic_workspace_symbols


    -- Set the background color of hover window to same as rest of document.
    vim.cmd [[
        hi NormalFloat guibg = Normal
        hi FloatBorder guibg = Normal
    ]]
end

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec(
            [[
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]], false)
    end
end

local function lsp_keymaps(client, bufnr)
    local opts = { noremap = true, silent = true }

    -- Declare functions for mapping in current buffer
    local function map(mode, keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set(mode, keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
    end

    local function nmap(keys, func, desc)
        map('n', keys, func, desc)
    end

    local function vmap(keys, func, desc)
        map('v', keys, func, desc)
    end

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    -- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- LSP Goto functions prefixed with 'g'
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.incoming_calls, "[G]oto [I]ncoming Calls")
    nmap("gO", vim.lsp.buf.outgoing_calls, "[G]oto [O]utgoing Calls")
    nmap("gs", vim.lsp.buf.document_symbol, "[G]oto Document [S]ymbol")
    nmap("gws", vim.lsp.buf.workspace_symbol, "[G]oto [W]orkspace [S]ymbol")

    -- LSP <leader> prefixed commands
    nmap("<leader>rn", require 'renamer'.rename, "[R]e[n]ame")

    nmap("<leader>a", "<cmd>CodeActionMenu<CR>", "Code [A]ction")

    nmap("<leader>gd", require 'telescope.builtin'.diagnostics, "[G]oto [D]iagnostics")
    nmap("<leader>ge", function()
        require 'telescope.builtin'.diagnostics { severity = "error" }
    end, "[G]oto [D]iagnostics")

    nmap("]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', "Next [D]iagnostic")
    nmap("[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', "Previous [D]iagnostic")
    nmap("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")

    nmap("]e", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded", severity = "error" })<CR>',
        "Next [E]rror")
    nmap("[e", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded", severity = "error" })<CR>',
        "Previous [E]rror")


    -- Lsp keymaps
    nmap("<leader>lr", "<cmd>LspRestart<CR>", "[L]SP [R]estart")

    -- Client specific maps
    if client.name == "rust_analyzer" then
        nmap("K", "<cmd>RustHoverActions<CR>", "Hover Documentation")
        nmap('<F5>', function()
            require 'hydra'.spawn('dap-hydra')
            vim.cmd [[RustDebuggables]]
        end, "Debug Start")
        nmap("<leader>m", require 'rust-tools.expand_macro'.expand_macro, "Expand [M]acro")
        nmap("<leader>ra", require 'rust-tools.hover_actions'.hover_actions, "[R]ust Hover [A]ctions")
        nmap("<leader>rod", require 'rust-tools.external_docs'.open_external_docs, "[R]ust [O]pen External [D]ocs")
    end

    -- Formatting
    nmap("F", vim.lsp.buf.format, "[F]ormat buffer")
    -- :Format command
    vim.cmd [[ command! Format execute 'lua pcall(vim.lsp.buf.format, {async=false})' ]]
end

-- On attach function is called once a lsp server is attached
M.on_attach = function(client, bufnr)
    lsp_keymaps(client, bufnr)
    lsp_highlight_document(client)

    -- Auto format on safe (version dependent)
    if client.server_capabilities.documentFormattingProvider and AUTO_FORMAT_EXCLUDED[client.name] == nil and
        AUTO_FORMAT_EXCLUDED[vim.bo[bufnr].filetype] == nil then
        enable_formatting(bufnr)
    end
    vim.notify("LSP Client: " .. client.name)
end

M.config = function(server_name)
    local config = {
        capabilities = require "cmp_nvim_lsp".default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = M.on_attach,
    }

    -- Load settings from usr/lsp/settings/$server_name
    local ok, server_config = pcall(require, "user.lsp.settings." .. server_name)


    -- Deep extend settings with custom lsp server settings
    if ok then
        config = vim.tbl_deep_extend("force", config, server_config)
    end

    return config
end

return M
