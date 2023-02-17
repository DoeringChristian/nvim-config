return {
    "echasnovski/mini.align",
    version = false,
    keys = {
        { "ga", desc = "Align" },
        { "gA", desc = "Align with Preview" },
    },
    config = function()
        require('mini.align').setup {}
    end
}
