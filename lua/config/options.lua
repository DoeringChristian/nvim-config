-- This file is automatically loaded -- :help options
local options = {
	backup = false,                       -- creates a backup file
	clipboard = "unnamedplus",            -- allows neovim to access the system clipboard
	cmdheight = 1,                        -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 2,                     -- concealed text is compleatly hidden except if it has a character assigned (see `:h conceallevel`)
	colorcolumn = "80",                   -- Set a line at the 80 character mark
	fileencoding = "utf-8",               -- the encoding written to a file
	hlsearch = true,                      -- highlight all matches on previous search pattern
	ignorecase = true,                    -- ignore case in search patterns
	mouse = "a",                          -- allow the mouse to be used in neovim
	pumheight = 10,                       -- pop up menu height
	showmode = false,                     -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2,                      -- always show tabs
	smartcase = true,                     -- smart case
	autoindent = true,
	smartindent = true,                   -- make indenting smarter again
	cindent = false,
	expandtab = true,                     -- convert tabs to spaces
	smarttab = false,
	splitbelow = true,                    -- force all horizontal splits to go below current window
	splitright = true,                    -- force all vertical splits to go to the right of current window
	swapfile = false,                     -- creates a swapfile
	termguicolors = true,                 -- set term gui colors (most terminals support this)
	timeoutlen = 300,                     -- time to wait for a mapped sequence to complete (in milliseconds)
	ttimeoutlen = 0,
	undofile = true,                      -- enable persistent undo
	updatetime = 300,                     -- faster completion (4000ms default)
	writebackup = false,                  -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	shiftwidth = 4,                       -- the number of spaces inserted for each indentation
	tabstop = 4,                          -- insert 2 spaces for a tab
	cursorline = true,                    -- highlight the current line
	number = true,                        -- set numbered lines
	relativenumber = true,                -- set relative numbered lines
	numberwidth = 2,                      -- set number column width to 2 {default 4}
	signcolumn = "yes:1",                 -- always show the sign column, otherwise it would shift the text each time
	wrap = false,                         -- display lines as one long line
	scrolloff = 8,                        -- is one of my fav
	sidescrolloff = 8,
	guifont = "FiraCode Nerd Font:h10",   -- the font used in graphical neovim applications
	foldcolumn = "0",                     -- An extra column, showing the foldlevel
	foldlevel = 99,                       -- Using ufo provider need a large value, feel free to decrease the value
	foldlevelstart = 99,
}

if vim.fn.has("nvim-0.10") == 1 then
	options.smoothscroll = true
end

vim.opt.shortmess:append("c")
vim.cmd([[
filetype plugin indent on
syntax on
]])

for k, v in pairs(options) do
	vim.opt[k] = v
end

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
