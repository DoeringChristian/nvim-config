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
        version = false,
        config = function()
            require "mini.ai".setup {
                n_lines = 1000,
            }
        end
    },
}
