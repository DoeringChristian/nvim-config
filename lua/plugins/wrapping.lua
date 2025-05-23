return {
    {
        "andrewferrier/wrapping.nvim",
        config = function()
            -- j/k should move in visual lines, not actual lines
            vim.keymap.set({ "n", "v" }, "j", "gj", { silent = true, desc = "Move down" })
            vim.keymap.set({ "n", "v" }, "k", "gk", { silent = true, desc = "Move up" })
            require "wrapping".setup()
        end
    },
}
