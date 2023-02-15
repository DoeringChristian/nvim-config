return {
    "jbyuki/venn.nvim",
    { "tpope/vim-sleuth",               event = "VeryLazy" },
    { "tpope/vim-surround",             event = "VeryLazy" },
    { "tpope/vim-repeat",               event = "VeryLazy" },
    { "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },
    { "numToStr/Comment.nvim",          opts = {} },
    { "lewis6991/gitsigns.nvim",        opts = {} },
    { "folke/which-key.nvim",           opts = {} },
    { "akinsho/toggleterm.nvim",        opts = {} },
    { "echasnovski/mini.align", version = false, config = function()
        require('mini.align').setup {}
    end },
    {
        "klen/nvim-config-local",
        config = function()
            require "config-local".setup {}
        end
    },
    {
        "windwp/nvim-spectre",
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "[S]earch [R]eplace" },
        },
    },
}
