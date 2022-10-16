-- Gruvbox-Baby --

--vim.g.gruvbox_baby_background_color = "dark"
--vim.cmd([[colorscheme gruvbox-baby]])

-- Gruvbox-Material
vim.cmd [[
if has('termguicolors')
    set termguicolors
endif

" For dark version.
set background=dark

" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'hard'

let g:gruvbox_material_foreground = 'original'

" For better performance
let g:gruvbox_material_better_performance = 1

let g:gruvbox_material_ui_contrast = 'high'

let g:gruvbox_material_show_eob = 'false'

colorscheme gruvbox-material

]]
