local icons = require "user.icons"

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "folke/noice.nvim",
    },
    opts = {
        options = {
            icons_enabled = true,
            --theme = 'gruvbox_dark',
            theme = 'gruvbox-material',
            component_separators = { left = '╲', right = '╲' },
            section_separators = { left = '◣', right = '◥' },
            disabled_filetypes = { "NvimTree", "aerial" },
            always_divide_middle = true,
            globalstatus = false,
        },
        sections = {
            lualine_a = {
                'mode',
                {
                    function()
                        return require "noice".api.statusline.mode.get()
                    end,
                    cond = function()
                        return require "noice".api.statusline.mode.has()
                    end,
                    color = { fg = "#ff9e64" },
                }
            },
            lualine_b = {
                'branch',
                'diff',
                {
                    'diagnostics',
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warn,
                        info = icons.diagnostics.Info,
                        hint = icons.diagnostics.Hint,
                    }
                },
            },
            lualine_c = {
                {
                    'filename',
                    file_status = true,
                    path = 1,
                },
                {
                    function()
                        return require "nvim-navic".get_location()
                    end,
                    cond = function()
                        return require "nvim-navic".is_available()
                    end
                }
            },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {}
    }
}
