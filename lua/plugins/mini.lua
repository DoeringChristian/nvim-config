return {
    "echasnovski/mini.align",
    version = false,
    keys = {
        { "ga", desc = "Align",              mode = { "n", "x" } },
        { "gA", desc = "Align with Preview", mode = { "n", "x" } },
    },
    config = function()
        require('mini.align').setup {}
    end
}
