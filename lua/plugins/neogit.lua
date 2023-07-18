return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim"
    },
    opts = {
        integrations = {
            diffview = true,
        },
    },
    config = function(_, opts)
        require "neogit".setup(opts)
    end,
}
