local M = {}
local icons = require("config.icons")

-- This function configures the common lsp frontend
M.setup = function()
    for name, icon in pairs(icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { texthl = name, text = icon, numhl = "" })
    end

    vim.diagnostic.config({
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
            border = "none",
            source = "always",
            header = "",
            prefix = "",
        },
    })

    -- Diagnostics window:
    vim.o.updatetime = 250
    vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focusable = false})]])

    -- Configure hover window NOTE: Gets overriden by noice.nvim
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {})

    -- Configure signatureHelp handlers
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {})

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        -- Disable a feature
        update_in_insert = true,
        -- -- Disable Virtual Text
        -- virtual_text = false,
        virtual_text = {
            severity = vim.diagnostic.severity.ERROR,
        },
    })

    -- Configure Telescope for lsp handlers

    vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references

    vim.lsp.handlers["textDocument/definition"] = require("telescope.builtin").lsp_definitions

    vim.lsp.handlers["textDocument/implementation"] = require("telescope.builtin").lsp_implementations

    vim.lsp.handlers["textDocument/documentSymbol"] = require("telescope.builtin").lsp_document_symbols

    vim.lsp.handlers["textDocument/typeDefinition"] = require("telescope.builtin").lsp_type_definitions

    vim.lsp.handlers["callHierarchy/incomingCalls"] = require("telescope.builtin").lsp_incoming_calls

    vim.lsp.handlers["callHierarchy/outgoingCalls"] = require("telescope.builtin").lsp_outgoing_calls

    vim.lsp.handlers["textDocument/documentSymbol"] = require("telescope.builtin").lsp_document_symbols

    vim.lsp.handlers["workspace/symbol"] = require("telescope.builtin").lsp_dynamic_workspace_symbols

    -- Set the background color of hover window to same as rest of document.
    vim.cmd([[
        hi NormalFloat guibg = Normal
        hi FloatBorder guibg = Normal
    ]])
end

--- Generates a config table from a server name
---@param Name of the server for which the config shall be generated
---@return returns the config table containing capabilities, on_attach, settings
M.config = function(server_name)
    local config = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = require("plugins.lsp.on_attach"),
    }

    -- Load settings from usr/lsp/settings/$server_name
    local ok, server_config = pcall(require, "config.lsp.settings." .. server_name)

    -- Deep extend settings with custom lsp server settings
    if ok then
        config = vim.tbl_deep_extend("force", config, server_config)
    end

    return config
end

return M
