return {
    'stevearc/aerial.nvim',
    keys = {
        { "<leader>nv", "<CMD>AerialNavOpen<CR>", desc = "[N]a[V] Open" },
    },
    opts = {
        close_automatic_events = { "unfocus" },
        autojump = false,
        nav = {
            preview = true,
            keymaps = {
                ["q"] = "actions.close",
                ["x"] = "actions.close",
            }
        }
    },
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
}
