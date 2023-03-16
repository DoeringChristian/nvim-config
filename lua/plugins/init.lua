return {
    { "jbyuki/venn.nvim",               event = "VeryLazy" },
    { "tpope/vim-sleuth",               event = "VeryLazy" },
    { "tpope/vim-surround",             event = "VeryLazy" },
    { "tpope/vim-repeat",               event = "VeryLazy" },
    { "kevinhwang91/nvim-hlslens",      event = "VeryLazy" },
    { "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },
    { "numToStr/Comment.nvim",          opts = {} },
    { "lewis6991/gitsigns.nvim",        opts = { sign_priority = 1 } },
    { "akinsho/toggleterm.nvim",        opts = {} },
    { "ray-x/lsp_signature.nvim",       opts = { noice = false } },
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
