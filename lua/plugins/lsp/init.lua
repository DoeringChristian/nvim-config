local function setup_slang()
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")
    local util = require("lspconfig/util")

    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = {
            "*.slang",
            "*.slangh",
            "*.hlsl",
            "*.usf",
            "*.ush",
        },
        callback = function()
            vim.cmd([[set filetype=slang]])
        end,
    })

    configs.slang = {
        default_config = {
            cmd = { "slangd" },
            filetypes = { "slang" },
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
            end,
            settings = {
                enableCommitCharactersInAutoCompletion = false,
            },
        },
        docs = {
            description = [[Language Server Protocoll for Slang]],
        },
    }

    -- vim.notify(vim.inspect(configs))
    lspconfig.slang.setup(require("plugins.lsp.handlers").config("slang"))
end

-- Fix for bug https://github.com/neovim/neovim/issues/12970
vim.lsp.util.apply_text_document_edit = function(text_document_edit, index, offset_encoding)
    local text_document = text_document_edit.textDocument
    local bufnr = vim.uri_to_bufnr(text_document.uri)
    if offset_encoding == nil then
        vim.notify_once('apply_text_document_edit must be called with valid offset encoding', vim.log.levels.WARN)
    end

    vim.lsp.util.apply_text_edits(text_document_edit.edits, bufnr, offset_encoding)
end

local function server(server_name)
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

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- "ray-x/lsp_signature.nvim",        -- function signature completions
        -- "nvimtools/none-ls.nvim", -- null-ls handles formatters etc.
        "nvim-telescope/telescope.nvim",
        "lukas-reineke/lsp-format.nvim",
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        -- NOTE: lsp settings are loaded by mason (rust-analyzer is handled by rust-tools)

        vim.cmd([[au BufNewFile,BufRead *.wgsl set filetype=wgsl]]) --wgsl fix
        vim.cmd([[au BufNewFile,BufRead *.pest set filetype=pest]]) --pest fix

        local lspconfig = require "lspconfig"

        setup_slang()
        lspconfig.glslls.setup {}

        -- -- lspconfig.rust_analyzer.setup(server("rust_analyzer"))
        -- lspconfig.ast_grep.setup(server("ast_grep"))
        -- lspconfig.basedpyright.setup(server("basedpyright"))
        -- -- lspconfig.clangd.setup(server("clangd"))
        -- lspconfig.cmake.setup(server("cmake-language-server"))
        -- lspconfig.esbonio.setup(server("esbonio"))
        -- lspconfig.glsl_analyzer.setup(server("glsl_analyzer"))
        -- lspconfig.jsonls.setup(server("json-lsp"))
        -- lspconfig.lua_ls.setup(server("luals"))
        -- lspconfig.matlab_ls.setup(server("matlab_ls"))
        -- lspconfig.nickel_ls.setup(server("nickel_ls"))
        -- lspconfig.nil_ls.setup(server("nil_ls"))
        -- lspconfig.ocamlls.setup(server("ocamlls"))
        -- lspconfig.pest_ls.setup(server("pest_ls"))
        -- lspconfig.ruff_lsp.setup(server("ruff_lsp"))
        -- lspconfig.ltex.setup(server("ltex"))
        -- lspconfig.texlab.setup(server("texlab"))
        -- lspconfig.markdown_oxide.setup(server("markdown_oxide"))
        -- lspconfig.typst_lsp.setup(server("typst_lsp"))
        -- lspconfig.wgsl_analyzer.setup(server("wgsl_analyzer"))

        -- Setup lspconfig: --
        local icons = require("config.icons")
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
                text = {
                    [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                    [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
                    [vim.diagnostic.severity.INFO] = icons.diagnostics.Hint,
                    [vim.diagnostic.severity.HINT] = icons.diagnostics.Info,
                },
                texthl = {
                    [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                    [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                    [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                    [vim.diagnostic.severity.HINT] = "DiagnosticHint",
                },
                -- TODO: fix priority mixup
                priority = 12, -- Is 8 so that errors can overwrite debug breakpoints
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
    end,
}
