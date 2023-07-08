return {
    "stevearc/dressing.nvim",
    lazy = true,
    opts = {
        select = {
            enabled = true,
            -- backend = "builtin", -- Telescope is brocken atm.
            telescope = {
                initial_mode = "normal",
            }
        }
    },
    init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
            require("lazy").load({ plugins = { "dressing.nvim" } })
            return vim.ui.select(...)
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
            require("lazy").load({ plugins = { "dressing.nvim" } })
            return vim.ui.input(...)
        end
    end,
}
