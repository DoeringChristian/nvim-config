return {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "jose-elias-alvarez/null-ls.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jayp0521/mason-null-ls.nvim",
        "jayp0521/mason-nvim-dap.nvim",
    },
    config = function()
        local mason = require "mason"
        local mason_lspconfig = require "mason-lspconfig"
        local mason_null_ls = require "mason-null-ls"
        local mason_nvim_dap = require "mason-nvim-dap"

        mason.setup {}
        mason_lspconfig.setup {
            ensure_installed = {
                'rust_analyzer',
                'ltex',
                'lua-language-server',
                'pyright',
                'texlab',
            }
        }
        mason_null_ls.setup {
            automatic_installation = true,
            ensure_installed = {
                'black',
            }
        }


        -- LSP Setup Handlers:
        local function lsp_default_handler(server_name)
            local lspconfig = require("lspconfig")
            local config = {
                capabilities = require("user.lsp.handlers").capabilities,
                on_attach = require("user.lsp.handlers").on_attach,
            }

            -- Load settings from usr/lsp/settings/$server_name
            local ok, settings_config = pcall(require, "user.lsp.settings." .. server_name)


            -- Deep extend settings with custom lsp server settings
            if ok then
                config = vim.tbl_deep_extend("force", config, settings_config)
            end

            lspconfig[server_name].setup(config)
        end

        mason_lspconfig.setup_handlers {
            lsp_default_handler,
            ["rust_analyzer"] = function()
            end
        }

        -- NULL-LS Setup Handlers
        local function null_ls_default_handler(source_name, methods)
            local ok, null_ls = pcall(require, "null-ls")
            if not ok then
                vim.notify("Error missing null-ls!")
                return
            end
            --vim.notify("Null-ls server " .. source_name .. " registered.")

            for k, v in pairs(methods) do
                null_ls.register(null_ls.builtins[v][source_name])
            end
        end

        mason_null_ls.setup_handlers {
            null_ls_default_handler
        }

        -- Setup Mason Dap
        mason_nvim_dap.setup {
            automatic_setup = true,
        }
        mason_nvim_dap.setup_handlers {
            function(source_name)
                -- all sources with no handler get passed here


                -- Keep original functionality of `automatic_setup = true`
                require 'mason-nvim-dap.automatic_setup' (source_name)
            end,
            python = function(source_name)
                local dap = require 'dap'
                dap.adapters.python = {
                    type = "executable",
                    command = "/usr/bin/python3",
                    args = {
                        "-m",
                        "debugpy.adapter",
                    },
                }

                dap.configurations.python = {
                    {
                        type = "python",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}", -- This configuration will launch the current file if used.
                    },
                }
            end,
        }
    end
}
