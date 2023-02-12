local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true

require "lazy".setup("plugins")


require "user.colorscheme"
require "user.keymaps"
require "user.options"

-- require "user.autocmds"
-- require "user.impatient"
-- require "user.options"
-- require "user.plugins"
-- require "user.colorscheme"
-- require "user.notify"
-- require "user.firenvim"
-- require "user.escape"
-- require "user.leap"
-- require "user.luasnip"
-- require "user.cmp"
-- require "user.mason"
-- require "user.lsp"
-- require "user.dap"
-- require "user.rust-tools"
-- require "user.yanky"
-- require "user.telescope"
-- require "user.hop"
-- require "user.nvim-tree"
-- require "user.autopairs"
-- require "user.treesitter"
-- require "user.gitsigns"
-- require "user.bufferline"
-- require "user.lualine"
-- require "user.which_key"
-- require "user.neoclip"
-- require "user.indent_blankline"
-- require "user.toggleterm"
-- require "user.pandoc"
-- require "user.keymaps"
-- require "user.aerial"
-- require "user.sniprun"
-- require "user.align"
-- require "user.signature"
-- require "user.tree-surfer"
-- require "user.renamer"
-- require "user.neovide"
-- require "user.hydra"
-- require "user.latex_live"
-- require "user.fold-preview"
-- require "user.comment"
