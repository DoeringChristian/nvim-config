return {
    { "tpope/vim-sleuth",   event = "VeryLazy" },
    { "tpope/vim-surround", event = "VeryLazy" },
    { "tpope/vim-repeat",   event = "VeryLazy" },
    { "tpope/vim-fugitive", event = "VeryLazy" },
    {
        "numToStr/Comment.nvim",
        opts = {
            mappings = {
                extra = false,
            }
        },
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring", }
    },
    { "akinsho/toggleterm.nvim", opts = {} },
    -- { "ray-x/lsp_signature.nvim", opts = { noice = false } },
    -- { "SvanT/lsp_signature.nvim", opts = { noice = false } },
    {
        "klen/nvim-config-local",
        config = function()
            require("config-local").setup({})
        end,
    },
    {
        "windwp/nvim-spectre",
        keys = {
            {
                "<leader>sr",
                function()
                    require("spectre").open()
                end,
                desc = "[S]earch [R]eplace",
            },
        },
    },
}
