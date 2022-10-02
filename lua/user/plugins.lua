local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
    use "kyazdani42/nvim-web-devicons"

    -- Colorschemes
    --use "morhetz/gruvbox"
    use "luisiacc/gruvbox-baby"

    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp" -- lsp completions
    use "lukas-reineke/cmp-rg"
    use "kdheepak/cmp-latex-symbols"
    --use "hrsh7th/cmp-nvim-lsp-signature-help" -- Signature completions
    use "ray-x/lsp_signature.nvim"
    use "f3fora/cmp-spell" -- Spelllang completions

    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    --use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    -- Mason
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }
    use "weilbith/nvim-code-action-menu"
    use "j-hui/fidget.nvim"
    use {
        "smjonas/inc-rename.nvim",
        cond = function()
            return vim.fn.has('nvim-0.8')
        end
    }

    -- Telescope --
    use {
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
    }
    use "gbprod/yanky.nvim"
    use "nvim-telescope/telescope-hop.nvim"
    use "tom-anders/telescope-vim-bookmarks.nvim"
    --use "ggandor/lightspeed.nvim"

    -- Rust --
    use "simrat39/rust-tools.nvim"

    -- Hop --
    use {
        "phaazon/hop.nvim",
        branch = "v1",
    }

    -- NvimTree --
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
    }

    -- Autopairs --
    use "windwp/nvim-autopairs"

    -- SmartPairs --
    --use "ZhiyuanLck/smart-pairs"

    -- TreeSitter --
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    -- GIT --
    use {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release
    }

    -- Impatient --
    use 'lewis6991/impatient.nvim'

    -- BufferLine --
    use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }

    -- Lualine --
    use "nvim-lualine/lualine.nvim"

    -- Which Key --
    use {
        "folke/which-key.nvim",
    }

    -- Neo Clip --
    use {
        "AckslD/nvim-neoclip.lua",
        requires = {
            -- you'll need at least one of these
            { 'nvim-telescope/telescope.nvim' },
            -- {'ibhagwan/fzf-lua'},
        }
    }

    -- Indent Blankline --
    use "lukas-reineke/indent-blankline.nvim"

    -- Debugging --
    use {
        "mfussenegger/nvim-dap",
        requires = {
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "nvim-telescope/telescope-dap.nvim",
        },
    }

    -- MiniYank --
    -- use "bfredl/nvim-miniyank"

    -- Toggleterm --
    use "akinsho/toggleterm.nvim"

    -- vim-surround --
    use "tpope/vim-surround"

    -- Vim-Bookmarks --
    use "MattesGroeger/vim-bookmarks"

    -- Better Escape --
    use { 'max397574/better-escape.nvim' }

    -- Nabla --
    use 'jbyuki/nabla.nvim'

    -- cmp-pandoc --
    use {
        'aspeddro/cmp-pandoc.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'jbyuki/nabla.nvim' -- optional
        }
    }

    -- Pandoc.Nvim --
    use "aspeddro/pandoc.nvim"

    -- Ariel --
    -- use "stevearc/aerial.nvim"

    -- Notify --
    use "rcarriga/nvim-notify"

    -- Sniprun --
    use { 'michaelb/sniprun', run = 'bash ./install.sh' }

    -- Easy Align --
    use "junegunn/vim-easy-align"

    -- Leap --
    use "ggandor/leap.nvim"

    -- Firenvim --
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }

    -- Local Nvim Config
    use {
        "klen/nvim-config-local",
        config = function()
            require('config-local').setup {}
        end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
