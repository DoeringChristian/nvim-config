return {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "jose-elias-alvarez/null-ls.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jay-babu/mason-null-ls.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "hrsh7th/cmp-nvim-lsp", -- lsp completions
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_null_ls = require("mason-null-ls")
        local mason_nvim_dap = require("mason-nvim-dap")

        mason.setup({
            registries = {
                "github:mason-org/mason-registry",
                -- "github:DoeringChristian/mason-registry",
            },
        })
        mason_lspconfig.setup({
            ensure_installed = {
                "rust_analyzer",
                "ltex",
                "lua_ls",
                -- 'pylsp',
                -- 'pyright',
                "texlab",
                "ruff_lsp",
            },
        })
        -- local function null_ls_default_handler(source_name, methods)
        --     local null_ls = require("null-ls")
        --
        --     for k, v in pairs(methods) do
        --         null_ls.register(null_ls.builtins[v][source_name])
        --     end
        -- end
        -- mason_null_ls.setup({
        --     automatic_installation = true,
        --     ensure_installed = {
        --         "black",
        --     },
        --     handlers = { null_ls_default_handler },
        -- })

        -- LSP Setup Handlers:
        local function lsp_default_handler(server_name)
            require("lspconfig")[server_name].setup(require("plugins.lsp.handlers").config(server_name))
        end

        mason_lspconfig.setup_handlers({
            lsp_default_handler,
            ["rust_analyzer"] = function() end, -- NOTE: When removing rust-tools or rustaceanvim remove this as well
            ["ltex"] = function() end,
        })
    end,
}
