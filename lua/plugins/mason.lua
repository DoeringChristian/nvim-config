return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "hrsh7th/cmp-nvim-lsp", -- lsp completions
        },
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")

            mason.setup {}
            mason_lspconfig.setup {
                automatic_installation = true,
            }

            local ensure_installed = {
                "ast-grep",
                "basedpyright",
                "black",
                "clang-format",
                "clangd",
                "cmake-language-server",
                "cmakelang",
                "cmakelint",
                "codelldb",
                "esbonio",
                "glsl_analyzer",
                "json-lsp",
                "latexindent",
                "ltex-ls",
                "ltex-ls-plus",
                "lua-language-server",
                "markdown-oxide",
                "matlab-language-server",
                "nickel-lang-lsp",
                "alejandra",
                "pest-language-server",
                "prettier",
                "prettierd",
                "ruff",
                "rust-analyzer",
                "texlab",
                "wgsl-analyzer",
                "taplo",
                "harper-ls",
                "tinymist",
                "nil",
            }

            local installed = require "mason-registry".get_installed_package_names()
            local installed_set = {}
            for _, pkg in ipairs(installed) do
                installed_set[pkg] = true
            end

            -- Install default tools, if not already installed
            for i, pkg in ipairs(ensure_installed) do
                if not installed_set[pkg] then
                    vim.cmd("MasonInstall " .. pkg)
                end
            end

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
    },
    {
        "williamboman/mason-lspconfig.nvim",
        -- Pinned for now, to prevent errors in python
        -- TODO: test in a few weeks
        version = "1.*",
    },
}
