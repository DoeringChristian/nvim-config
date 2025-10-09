-- Minimal config for kitty-scrollback.nvim
--
-- basic mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.termguicolors = true

vim.opt.runtimepath:append(vim.fn.stdpath 'data' .. '/lazy/better-escape.vim') -- lazy.nvim
vim.g.better_escape_shortcut = { 'jk', 'jK', 'JK', 'Jk' }
vim.g.better_escape_interval = 1000

-- Setup leap.nvim
vim.opt.runtimepath:append(vim.fn.stdpath 'data' .. '/lazy/leap.nvim')

local leap = require 'leap'
leap.set_default_keymaps()
leap.setup {
  max_phase_one_targets = nil,
  highlight_unlabeled_phase_one_targets = false,
  max_highlighted_traversal_targets = 10,
  case_sensitive = false,
  equivalence_classes = { ' \t\r\n' },
  substitute_chars = {},
  relative_directions = true,
  labels = {
    's',
    'f',
    'n',
    'u',
    't',
    'r',
    'j',
    'k',
    'l',
    'o',
    'd',
    'w',
    'e',
    'h',
    'm',
    'v',
    'g',
    'c',
    '.',
    'z',
  },
  safe_labels = { 's', 'f', 'n', 'u', 't', 'r' },
  --"F", "L", "N", "H", "G", "M", "U", "T", "Z" },
  special_keys = {
    repeat_search = '<enter>',
    next_phase_one_target = '<enter>',
    next_target = { '<enter>', ';' },
    prev_target = { '<tab>', ',' },
    next_group = '<space>',
    prev_group = '<tab>',
    multi_accept = '<enter>',
    multi_revert = '<backspace>',
  },
}

vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })

-- add kitty-scrollback.nvim to the runtimepath to allow us to require the kitty-scrollback module
-- pick a runtimepath that corresponds with your package manager, if you are not sure leave them all it will not cause any issues
vim.opt.runtimepath:append(vim.fn.stdpath 'data' .. '/lazy/kitty-scrollback.nvim') -- lazy.nvim
local ksb = require 'kitty-scrollback'
ksb.setup {
  -- put your kitty-scrollback.nvim configurations here
  function()
    local ksb_api = require 'kitty-scrollback.api'

    -- Yank mappings
    vim.keymap.set({ 'n' }, 'Y', '"+Y', { noremap = true, silent = true, desc = '' })
    vim.keymap.set({ 'v' }, 'Y', '"+Y', { noremap = true, silent = true, desc = '' })

    vim.keymap.set({ 'n' }, 'yy', '"+yy', { noremap = true, silent = true, desc = '' })

    vim.keymap.set({ 'n' }, 'y', '"+y', { noremap = true, silent = true, desc = '' })
    vim.keymap.set({ 'v' }, 'y', '"+y', { noremap = true, silent = true, desc = '' })

    vim.keymap.set('n', 'q', function()
      ksb_api.close_or_quit_all()
    end, { noremap = true, silent = true, desc = '[Q]uit' })
    vim.keymap.set('n', 'i', function()
      ksb_api.close_or_quit_all()
    end, { noremap = true, silent = true, desc = '[Q]uit' })

    -- Navigate
    vim.keymap.set({ 'n' }, '<C-h>', '<C-w>h', { noremap = true, silent = true, desc = '' })
    vim.keymap.set({ 'n' }, '<C-j>', '<C-w>j', { noremap = true, silent = true, desc = '' })
    vim.keymap.set({ 'n' }, '<C-k>', '<C-w>k', { noremap = true, silent = true, desc = '' })
    vim.keymap.set({ 'n' }, '<C-l>', '<C-w>l', { noremap = true, silent = true, desc = '' })

    return {
      callbacks = {
        after_ready = function()
          -- Disable Yank post autocmd
          -- https://github.com/mikesmithgh/kitty-scrollback.nvim/blob/dc101d0a8356db9c7290dfbfa82c27ec35e3b55a/lua/kitty-scrollback/autocommands.lua#L138
          vim.api.nvim_del_augroup_by_name 'KittyScrollBackNvimTextYankPost'
        end,
      },
      keymaps_enabled = false,
    }
  end,
}
