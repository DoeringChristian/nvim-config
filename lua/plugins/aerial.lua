return {
    'stevearc/aerial.nvim',
    keys = {
        { "<leader>nv", "<CMD>AerialNavOpen<CR>", desc = "[N]a[V] Open" },
        {
            "<leader>no",
            function()
                return require "aerial".toggle { focus = false }
            end,
            desc = "[N]avigation [O]utliner"
        },
    },
    opts = {
        close_automatic_events = { "unfocus" },
        autojump = true,
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
