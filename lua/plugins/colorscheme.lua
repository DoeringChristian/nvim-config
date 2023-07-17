return {
    {
        "sainnhe/gruvbox-material",
        enabled = false,
        priority = 1000,
        config = function()
            --" Set contrast.
            --" This configuration option should be placed before `colorscheme gruvbox-material`.
            --" Available values: 'hard', 'medium'(default), 'soft'
            vim.g.gruvbox_material_background = 'hard'

            vim.g.gruvbox_material_foreground = 'original'

            --" For better performance
            vim.g.gruvbox_material_better_performance = 1

            vim.g.gruvbox_material_ui_contrast = 'high'

            vim.g.gruvbox_material_show_eob = 'false'
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        enabled = false,
        priority = 1000,
        opts = {
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                comments = true,
                operators = true,
                folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true,    -- invert background for search, diffs, statuslines and errors
            contrast = "hard", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        }
    },
    {
        "luisiacc/gruvbox-baby",
        priority = 1000,
        config = function()
            vim.g.gruvbox_baby_background_color = "dark"
            vim.cmd [[set background=dark]]

            vim.cmd.colorscheme "gruvbox-baby"

            vim.cmd [[hi IndentBlanklineIndent guifg = #282828]]
        end
    }
}
