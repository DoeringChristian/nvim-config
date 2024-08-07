-- Minimal config for kitty-scrollback.nvim
--
-- basic mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true

vim.opt.runtimepath:append(vim.fn.stdpath "data" .. "/lazy/better-escape.vim") -- lazy.nvim
vim.g.better_escape_shortcut = { "jk", "jK", "JK", "Jk" }
vim.g.better_escape_interval = 1000

vim.opt.runtimepath:append(vim.fn.stdpath "data" .. "/lazy/yanky.nvim") -- lazy.nvim

local yanky = require "yanky"

yanky.setup({
    ring = {
        history_length = 10,
        storage = "shada",
        sync_with_numbered_registers = true,
    },
    system_clipboard = {
        sync_with_ring = true,
    },
    preserver_cursor_position = {
        enabled = false,
    },
})

-- add kitty-scrollback.nvim to the runtimepath to allow us to require the kitty-scrollback module
-- pick a runtimepath that corresponds with your package manager, if you are not sure leave them all it will not cause any issues
vim.opt.runtimepath:append(vim.fn.stdpath "data" .. "/lazy/kitty-scrollback.nvim") -- lazy.nvim
local ksb = require "kitty-scrollback"
ksb.setup {
    -- put your kitty-scrollback.nvim configurations here
    function()
        local ksb_api = require "kitty-scrollback.api"
        vim.keymap.set({ 'v' }, 'Y', '<Plug>(KsbVisualYankLine)', {})
        vim.keymap.set({ 'v' }, 'y', '<Plug>(KsbVisualYank)', {})
        vim.keymap.set({ 'n' }, 'Y', '<Plug>(KsbNormalYankEnd)', {})
        vim.keymap.set({ 'n' }, 'y', '<Plug>(KsbNormalYank)', {})
        vim.keymap.set({ 'n' }, 'yy', '<Plug>(KsbYankLine)', {})
        vim.keymap.set("n", "q", function() ksb_api.close_or_quit_all() end,
            { noremap = true, silent = true, desc = "[Q]uit" })
        vim.keymap.set("n", "i", function() ksb_api.close_or_quit_all() end,
            { noremap = true, silent = true, desc = "[Q]uit" })

        -- Navigate
        vim.keymap.set({ "n" }, "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "" })
        vim.keymap.set({ "n" }, "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "" })
        vim.keymap.set({ "n" }, "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "" })
        vim.keymap.set({ "n" }, "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "" })
        return {
            paste_window = { yank_register = 'a' },
        }
    end
}
