return {
    {
        "sainnhe/gruvbox-material",
        enabled = true,
        lazy = true,
        priority = 1000,
        config = function()
            --" Set contrast.
            --" This configuration option should be placed before `colorscheme gruvbox-material`.
            --" Available values: 'hard', 'medium'(default), 'soft'
            vim.g.gruvbox_material_background = "hard"

            vim.g.gruvbox_material_foreground = "original"

            --" For better performance
            vim.g.gruvbox_material_better_performance = 1

            vim.g.gruvbox_material_ui_contrast = "high"

            vim.g.gruvbox_material_show_eob = "false"
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        enabled = true,
        lazy = true,
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
        },
    },
    {
        "catppuccin/nvim",
        lazy = true,
        priority = 1000,
        name = "catppuccin",
        opts = {
            integrations = {
                alpha = true,
                cmp = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                lsp_trouble = true,
                diffview = true,
                mason = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                noice = true,
                notify = true,
                neotree = true,
                semantic_tokens = true,
                telescope = {
                    enabled = true,
                    style = "nvchad",
                },
                treesitter = true,
                ufo = true,
                which_key = true,
                window_picker = true,
                render_markdown = true,
            },
            custom_highlights = function(colors)
                local groups = {
                    CmpItemMenu                   = { fg = colors.overlay0 },
                    FzfLuaNormal                  = { bg = colors.mantle },
                    RenderMarkdownCode            = { bg = colors.mantle },
                    RenderMarkdownCodeInline      = { bg = colors.mantle },
                    RenderMarkdownInlineHighlight = { fg = colors.yellow, bg = colors.mantle },
                    MarkviewCode                  = { bg = colors.mantle },
                    MarkviewInlineCode            = { bg = colors.mantle },
                }

                local U = require "catppuccin.utils.colors"
                local rainbow = {
                    colors.red,
                    colors.peach,
                    colors.yellow,
                    colors.green,
                    colors.sapphire,
                    colors.lavender
                }
                for i = 1, 6 do
                    local color = rainbow[i]
                    groups["MarkviewHeading" .. i] = { fg = color, bg = U.darken(color, 0.30, colors.base) }
                end

                return groups
            end,
        },
    },
    {
        "luisiacc/gruvbox-baby",
        priority = 1000,
        config = function()
            vim.g.gruvbox_baby_background_color = "dark"
            vim.g.gruvbox_baby_function_style = "NONE"
            vim.g.gruvbox_baby_keyword_style = "italic"
            -- vim.g.gruvbox_baby_telescope_theme = 1

            -- vim.g.gruvbox_baby_color_overrides = {
            --     dark_gray = "#3c3836",
            -- }

            vim.cmd([[set background=dark]])
        end,
    },
}
