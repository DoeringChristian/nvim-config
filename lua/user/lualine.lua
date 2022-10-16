local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end

function ESCAPE_STATUS()
    local ok, m = pcall(require, "better_escape")
    return ok and m.waiting and '✺' or ""
end

lualine.setup {
    options = {
        icons_enabled = true,
        --theme = 'gruvbox_dark',
        theme = 'gruvbox-material',
        component_separators = { left = '\\', right = '\\' },
        section_separators = { left = '◣', right = '◥' },
        disabled_filetypes = { "NvimTree", "aerial" },
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            'branch',
            'diff',
            'diagnostics',
        },
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,
            }
        },
        lualine_x = { 'ESCAPE_STATUS()', 'encoding', 'fileformat', 'filetype' },
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
