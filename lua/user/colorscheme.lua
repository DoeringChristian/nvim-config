local colorscheme = 'gruvbox-material'


local configs = {
    ["gruvbox-baby"] = function()
        vim.g.gruvbox_baby_background_color = "dark"
        vim.cmd([[colorscheme gruvbox-baby]])
    end,
    ["gruvbox-material"] = function()
        vim.cmd [[
        if has('termguicolors')
            set termguicolors
        endif

        " For dark version.
        set background=dark
        ]]

        --" Set contrast.
        --" This configuration option should be placed before `colorscheme gruvbox-material`.
        --" Available values: 'hard', 'medium'(default), 'soft'
        vim.g.gruvbox_material_background = 'hard'

        vim.g.gruvbox_material_foreground = 'original'

        --" For better performance
        vim.g.gruvbox_material_better_performance = 1

        vim.g.gruvbox_material_ui_contrast = 'high'

        vim.g.gruvbox_material_show_eob = 'false'

        vim.cmd[[colorscheme gruvbox-material]]
    end
}

configs[colorscheme]()
