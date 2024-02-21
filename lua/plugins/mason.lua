return {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "jose-elias-alvarez/null-ls.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jayp0521/mason-null-ls.nvim",
        "jayp0521/mason-nvim-dap.nvim",
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
        local function null_ls_default_handler(source_name, methods)
            local null_ls = require("null-ls")

            for k, v in pairs(methods) do
                null_ls.register(null_ls.builtins[v][source_name])
            end
        end
        mason_null_ls.setup({
            automatic_installation = true,
            ensure_installed = {
                "black",
            },
            handlers = { null_ls_default_handler },
        })

        -- LSP Setup Handlers:
        local function lsp_default_handler(server_name)
            require("lspconfig")[server_name].setup(require("plugins.lsp.handlers").config(server_name))
        end

        mason_lspconfig.setup_handlers({
            lsp_default_handler,
            ["rust_analyzer"] = function() end, -- NOTE: When removing rust-tools or rustaceanvim remove this as well
            ["ltex"] = function() end,
        })

        -- Slang setup:

        -- local configs = require "lspconfig.configs"
        -- local slang = require "mason-registry".get_package("shader-slang")
        -- configs.slang = {
        --     default_config = {
        --         cmd = { slang:get_install_path() }
        --     }
        -- }

        -- Setup Mason Dap
        -- mason_nvim_dap.setup({
        --     automatic_setup = true,
        --     handlers = {
        --         function(config)
        --             -- all sources with no handler get passed here
        --
        --             -- Keep original functionality of `automatic_setup = true`
        --             require("mason-nvim-dap.automatic_setup")(config)
        --             require("mason-nvim-dap").default_setup(config)
        --         end,
        --         python = function(config)
        --             local dap = require("dap")
        --             dap.adapters.python = {
        --                 type = "executable",
        --                 command = "/usr/bin/python3",
        --                 args = {
        --                     "-m",
        --                     "debugpy.adapter",
        --                 },
        --             }
        --
        --             dap.configurations.python = {
        --                 {
        --                     type = "python",
        --                     request = "launch",
        --                     name = "Launch file",
        --                     program = "${file}", -- This configuration will launch the current file if used.
        --                 },
        --             }
        --             require("mason-nvim-dap").default_setup(config)
        --         end,
        --     },
        -- })
    end,
}
