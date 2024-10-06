return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "hrsh7th/cmp-nvim-lsp", -- lsp completions
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

        mason.setup {}
        require "mason-tool-installer".setup {
            run_on_start = false,
            ensure_installed = {
                "ast-grep",
                "basedpyright",
                "black",
                "clang-format",
                "clangd",
                "cmake-language-server",
                "cmakelang",
                "cmakelint",
                "codelldb",
                "erb-formatter",
                "esbonio",
                "glsl_analyzer",
                "json-lsp",
                "latexindent",
                "ltex-ls",
                "lua-language-server",
                "markdown-oxide",
                "matlab-language-server",
                "nickel-lang-lsp",
                "nil",
                "nixpkgs-fmt",
                "pest-language-server",
                "prettier",
                "prettierd",
                "ruff-lsp",
                "rust-analyzer",
                "texlab",
                "typst-lsp",
                "typstfmt",
                "wgsl-analyzer",
            }
        }
        mason_lspconfig.setup {
            automatic_installation = true,
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
