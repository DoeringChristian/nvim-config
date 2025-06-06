return {
    "folke/noice.nvim",
    -- Had to disable, was causing to much lag
    enabled = false,
    event = "VeryLazy",
    opts = {
        lsp = {
            signature = {
                enabled = true,
            },
            hover = {
                enabled = false,
            },
            progress = {
                enabled = false,
            }
        },
        cmdline = {
            enabled = false,
        },
        messages = {
            enabled = false,
        },
        views = {
            cmdline_popup = {
                border = {
                    style = "none",
                    padding = { 2, 3 },
                },
                filter_options = {},
                win_options = {
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                },
            },
        },
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    }
}
