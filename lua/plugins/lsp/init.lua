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

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- "ray-x/lsp_signature.nvim",        -- function signature completions
        -- "nvimtools/none-ls.nvim", -- null-ls handles formatters etc.
        "nvim-telescope/telescope.nvim",
        "lukas-reineke/lsp-format.nvim",
        "stevearc/conform.nvim",
    },
    config = function()
        -- NOTE: lsp settings are loaded by mason (rust-analyzer is handled by rust-tools)

        vim.cmd([[au BufNewFile,BufRead *.wgsl set filetype=wgsl]]) --wgsl fix
        vim.cmd([[au BufNewFile,BufRead *.pest set filetype=pest]]) --pest fix

        setup_slang()
        require 'lspconfig'.glslls.setup {}

        require "plugins.lsp.handlers".setup()
    end,
}
