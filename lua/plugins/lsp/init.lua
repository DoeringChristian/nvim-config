return {
    {

    "neovim/nvim-lspconfig",
    dependencies = {
        -- "ray-x/lsp_signature.nvim",        -- function signature completions
        "jose-elias-alvarez/null-ls.nvim", -- null-ls handles formatters etc.
        "nvim-telescope/telescope.nvim",
        "lukas-reineke/lsp-format.nvim",
    },
    config = function()
        -- NOTE: lsp settings are loaded by mason (rust-analyzer is handled by rust-tools)

        -- Functions for enabling/disabling auto formatting

        vim.cmd [[command! Fm execute 'lua enable_formatting()']]
        vim.cmd [[command! NFm execute 'lua disable_formatting()']]
        vim.cmd [[command! NoFm execute 'lua disable_formatting()']]

        vim.cmd [[au BufNewFile,BufRead *.wgsl set filetype=wgsl]] --wgsl fix

        setup_slang()

        --require "user.lsp.lsp-installer"
        require "user.lsp.handlers".setup()

        require "lsp-format".setup {}
    end
},
}