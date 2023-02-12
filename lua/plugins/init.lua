return {
    'tpope/vim-sleuth',
    "tpope/vim-surround",
    "jbyuki/venn.nvim",
    { "numToStr/Comment.nvim",   opts = {} },
    { "lewis6991/gitsigns.nvim", opts = {} },
    { "folke/which-key.nvim",    opts = {} },
    { "akinsho/toggleterm.nvim", opts = {} },
    {
        "klen/nvim-config-local",
        config = function()
            require "config-local".setup {}
        end
    },
}
