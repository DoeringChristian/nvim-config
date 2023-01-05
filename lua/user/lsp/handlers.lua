local M = {}

-- This function configures the common lsp frontend
M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    vim.g.code_action_menu_window_border = "rounded"

    local config = {
        -- set virtual text
        virtual_text = false,
        -- show signs
        signs = {
            active = signs,
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

    -- Configure hover window
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })
    --vim.lsp.handlers["textDocument/hover"] = require('rust-tools.hover_actions').hover_actions

    -- Configure signatureHelp handlers
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
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

    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    -- LSP Goto functions prefixed with 'g'
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gO", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)

    -- LSP <leader> prefixed commands
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua require('renamer').rename()<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>rn", "<cmd>lua require('renamer').rename()<cr>", opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>a", "<cmd>CodeActionMenu<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>a", "<cmd>CodeActionMenu<CR>", opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>d", "<cmd>lua require'telescope.builtin'.diagnostics()<CR>", opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gl",
        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)


    -- Lsp keymaps
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", "<cmd>LspRestart<CR>", opts)

    -- Client specific maps
    if client.name == "rust_analyzer" then
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>m", ":lua require'rust-tools.expand_macro'.expand_macro() <CR>"
            , opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ra",
            ":lua require'rust-tools.hover_actions'.hover_actions() <CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ri",
            ":lua require'rust-tools.inlay_hints'.toggle_inlay_hints() <CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rod",
            ":lua require'rust-tools.external_docs'.open_external_docs() <CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "K", '<cmd>RustHoverActions<CR>', opts)
    end

    -- Formatting
    vim.api.nvim_buf_set_keymap(bufnr, "n", "F", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- :Format command
    vim.cmd [[ command! Format execute 'lua pcall(vim.lsp.buf.format, {async=false})' ]]
end

-- On attach function is called once a lsp server is attached
M.on_attach = function(client, bufnr)
    lsp_keymaps(client, bufnr)
    lsp_highlight_document(client)

    -- Client dependent settings
    if client.name == "tsserver" then
        --client.resolved_capabilities.document_formatting = false
        client.server_capabilities['document_formatting'] = false
    end

    -- Auto format on safe (version dependent)
    if client.server_capabilities.documentFormattingProvider and AUTO_FORMAT_EXCLUDED[client.name] == nil and
        AUTO_FORMAT_EXCLUDED[vim.bo[bufnr].filetype] == nil then
        enable_formatting(bufnr)
    end
    vim.notify("LSP Client: " .. client.name)
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    return
end

M.capabilities = cmp_nvim_lsp.default_capabilities()
M.capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), M.capabilities)
--print(dump(M.capabilities))

return M
