local icons = require "user.icons"

local function fg(name)
    return function()
        ---@type {foreground?:number}?
        local hl = vim.api.nvim_get_hl_by_name(name, true)
        return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
    end
end


return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        -- "folke/noice.nvim",
    },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'gruvbox-baby',
            -- theme = 'gruvbox-material',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            -- component_separators = { left = '╲', right = '╲' },
            -- section_separators = { left = '◣', right = '◥' },
            disabled_filetypes = { "NvimTree", "aerial" },
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1,
                tabline = 1,
                winbar = 1,
            }
        },
        sections = {
            lualine_a = {
                'mode',
                { function()
                    return require "recorder".recordingStatus()
                end },
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
            },
            lualine_x = {
                -- -- stylua: ignore
                -- {
                --     function() return require("noice").api.status.command.get() end,
                --     cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                --     color = fg("Statement")
                -- },
                -- -- stylua: ignore
                -- {
                --     function() return require("noice").api.status.mode.get() end,
                --     cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                --     color = fg("Constant"),
                -- },
                'encoding', 'fileformat', 'filetype'
            },
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
        extensions = {},
    },
    config = function(_, opts)
        -- Patch gruvbox-baby theme
        local theme = require "lualine.themes.gruvbox-baby"
        local c = require("gruvbox-baby.colors").config()

        theme.inactive = {
            a = { bg = c.background, fg = c.gray, gui = "bold" },
            b = { bg = c.background, fg = c.gray },
            c = { bg = c.background, fg = c.gray },
        }
        opts.options.theme = theme

        require "lualine".setup(opts)
    end,
}
