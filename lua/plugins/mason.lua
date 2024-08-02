return {
    "williamboman/mason.nvim",
    dependencies = {
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

        mason.setup {
            registries = {
                "github:mason-org/mason-registry",
                -- "github:DoeringChristian/mason-registry",
            },
        }
        mason_lspconfig.setup {
            automatic_instalation = true,
        }

        -- Enable this if we want auto-setup
        -- -- LSP Setup Handlers:
        -- local function lsp_default_handler(server_name)
        --     require("lspconfig")[server_name].setup(require("plugins.lsp.handlers").config(server_name))
        -- end
        --
        -- mason_lspconfig.setup_handlers({
        --     lsp_default_handler,
        --     ["rust_analyzer"] = function() end, -- NOTE: When removing rust-tools or rustaceanvim remove this as well
        --     ["ltex"] = function() end,
        -- })
    end,
}
