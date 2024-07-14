return {
    {
        "echasnovski/mini.align",
        version = false,
        keys = {
            { "ga", desc = "Align",              mode = { "n", "x" } },
            { "gA", desc = "Align with Preview", mode = { "n", "x" } },
        },
        config = function()
            require("mini.align").setup({})
        end,
    },
    {
        "echasnovski/mini.pairs",
        enabled = false,
        event = "VeryLazy",
        opts = {},
    },
    {
        "echasnovski/mini.ai",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            { "nvim-treesitter/nvim-treesitter-textobjects", },
        },
        version = false,
        enabled = true,
        config = function()
            local gen_spec = require "mini.ai".gen_spec
            require "mini.ai".setup {
                n_lines = 1000,
                custom_textobjects = {
                    F = gen_spec.treesitter {
                        a = { "@function.outer" },
                        i = { "@function.inner" }
                    },
                    o = gen_spec.treesitter {
                        a = { "@function.outer", "@class.outer", "@loop.outer", "@conditional.outer", "@comment.outer" },
                        i = { "@function.inner", "@class.inner", "@loop.inner", "@conditional.inner", "@comment.inner" }
                    },
                }
            }
        end
    },
}
