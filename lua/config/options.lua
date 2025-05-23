-- This file is automatically loaded -- :help options

vim.o.fileencoding = "utf-8"

vim.o.autoindent = true
vim.o.smartindent = true

-- Highlight the line number on which the cursor currently is to make it easier to spot. Don't highlight the line itself
-- as that messes with transparent background.
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- Show trailing spaces and tabs. Also, setting non-trailing tabs as "  " makes the cursor go to their beginning rather
-- than end.
vim.o.list = true
vim.o.listchars = "tab:→ ,lead:·,trail:·,precedes:←,extends:→"
vim.o.fillchars = "vert: ,eob:~"
vim.o.virtualedit = "all"
vim.o.conceallevel = 2

-- Actual line number on current line, relative line numbers otherwise to make precise jumps possible.
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2 -- set number column width to 2 {default 4}

-- Various "widths" and "heights" that the editor should respect.
vim.o.scrolloff = 16
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.signcolumn = "yes:1"

-- Infinite undo, persistent undo
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.o.undofile = true

-- Folding
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldcolumn = "0"

-- Misc
vim.o.showmode = false
vim.o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.o.hidden = true
vim.o.updatetime = 50
vim.o.colorcolumn = "80" -- Set a line at the 80 character mark
vim.o.wrap = true

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.cindent = false

vim.o.pumheight = 10

-- Lowercase search: insensitive
-- Uppercase letters in search: sensitive
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.guifont = "FiraCode Nerd Font:h10"




if vim.fn.has("nvim-0.10") == 1 then
	options.smoothscroll = true
end

vim.opt.shortmess:append("c")
vim.cmd([[
filetype plugin indent on
syntax on
]])

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work

-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
if vim.fn.has("nvim-0.10") == 1 then
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
else
	vim.opt.foldmethod = "indent"
end

-- Old config
-- local options = {
-- 	backup = false,                       -- creates a backup file
-- 	clipboard = "unnamedplus",            -- allows neovim to access the system clipboard
-- 	cmdheight = 1,                        -- more space in the neovim command line for displaying messages
-- 	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
-- 	conceallevel = 2,                     -- concealed text is compleatly hidden except if it has a character assigned (see `:h conceallevel`)
-- 	colorcolumn = "80",                   -- Set a line at the 80 character mark
-- 	fileencoding = "utf-8",               -- the encoding written to a file
-- 	hlsearch = true,                      -- highlight all matches on previous search pattern
-- 	ignorecase = true,                    -- ignore case in search patterns
-- 	mouse = "a",                          -- allow the mouse to be used in neovim
-- 	pumheight = 10,                       -- pop up menu height
-- 	showmode = false,                     -- we don't need to see things like -- INSERT -- anymore
-- 	showtabline = 2,                      -- always show tabs
-- 	smartcase = true,                     -- smart case
-- 	autoindent = true,
-- 	smartindent = true,                   -- make indenting smarter again
-- 	cindent = false,
-- 	expandtab = true,                     -- convert tabs to spaces
-- 	smarttab = false,
-- 	splitbelow = true,                    -- force all horizontal splits to go below current window
-- 	splitright = true,                    -- force all vertical splits to go to the right of current window
-- 	swapfile = false,                     -- creates a swapfile
-- 	termguicolors = true,                 -- set term gui colors (most terminals support this)
-- 	timeoutlen = 300,                     -- time to wait for a mapped sequence to complete (in milliseconds)
-- 	ttimeoutlen = 0,
-- 	undofile = true,                      -- enable persistent undo
-- 	updatetime = 300,                     -- faster completion (4000ms default)
-- 	writebackup = false,                  -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
-- 	shiftwidth = 4,                       -- the number of spaces inserted for each indentation
-- 	tabstop = 4,                          -- insert 2 spaces for a tab
-- 	cursorline = true,                    -- highlight the current line
-- 	number = true,                        -- set numbered lines
-- 	relativenumber = true,                -- set relative numbered lines
-- 	numberwidth = 2,                      -- set number column width to 2 {default 4}
-- 	signcolumn = "yes:1",                 -- always show the sign column, otherwise it would shift the text each time
-- 	wrap = false,                         -- display lines as one long line
-- 	scrolloff = 8,                        -- is one of my fav
-- 	sidescrolloff = 8,
-- 	guifont = "FiraCode Nerd Font:h10",   -- the font used in graphical neovim applications
-- 	foldcolumn = "0",                     -- An extra column, showing the foldlevel
-- 	foldlevel = 99,                       -- Using ufo provider need a large value, feel free to decrease the value
-- 	foldlevelstart = 99,
-- 	foldenable = true,
-- }
