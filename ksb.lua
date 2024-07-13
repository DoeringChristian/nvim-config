-- Minimal config for kitty-scrollback.nvim

-- add kitty-scrollback.nvim to the runtimepath to allow us to require the kitty-scrollback module
-- pick a runtimepath that corresponds with your package manager, if you are not sure leave them all it will not cause any issues
vim.opt.runtimepath:append(vim.fn.stdpath "data" .. "/lazy/kitty-scrollback.nvim") -- lazy.nvim
require "kitty-scrollback".setup {
    -- put your kitty-scrollback.nvim configurations here
}

-- Load catppuccin
vim.opt.runtimepath:append(vim.fn.stdpath "data" .. "/lazy/catppuccin") -- lazy.nvim
vim.cmd.colorscheme "catppuccin"

-- basic mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true
