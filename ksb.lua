-- Minimal config for kitty-scrollback.nvim
--
-- basic mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true

vim.opt.runtimepath:append(vim.fn.stdpath "data" .. "/lazy/better-escape.vim") -- lazy.nvim
vim.g.better_escape_shortcut = { "jk", "jK", "JK", "Jk" }
vim.g.better_escape_interval = 1000

-- add kitty-scrollback.nvim to the runtimepath to allow us to require the kitty-scrollback module
-- pick a runtimepath that corresponds with your package manager, if you are not sure leave them all it will not cause any issues
vim.opt.runtimepath:append(vim.fn.stdpath "data" .. "/lazy/kitty-scrollback.nvim") -- lazy.nvim
local ksb = require "kitty-scrollback"
ksb.setup {
    -- put your kitty-scrollback.nvim configurations here
}

local ksb_api = require "kitty-scrollback.api"
vim.keymap.set("n", "q", function() ksb_api.close_or_quit_all() end, { noremap = true, silent = true, desc = "[Q]uit" })
