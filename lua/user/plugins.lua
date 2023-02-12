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
        use "sainnhe/gruvbox-material"

        -- cmp plugins
        use "hrsh7th/nvim-cmp" -- The completion plugin
        use "hrsh7th/cmp-buffer" -- buffer completions
        use "hrsh7th/cmp-path" -- path completions
        use "hrsh7th/cmp-cmdline" -- cmdline completions
        use "saadparwaiz1/cmp_luasnip" -- snippet completions
        use "hrsh7th/cmp-nvim-lsp" -- lsp completions
        use "lukas-reineke/cmp-rg" -- ripgrep completions
        use "kdheepak/cmp-latex-symbols" -- latex symbol completions
        --use "hrsh7th/cmp-nvim-lsp-signature-help" -- Signature completions
        use "ray-x/lsp_signature.nvim" -- function signature completions
        use "f3fora/cmp-spell" -- vim spelling completions
        use "vappolinario/cmp-clippy"

        -- snippets
        use "L3MON4D3/LuaSnip" --snippet engine
        use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

        -- LSP
        use "neovim/nvim-lspconfig" -- enable LSP
        use "jose-elias-alvarez/null-ls.nvim" -- null-ls handles formatters etc.

        -- Mason
        -- > Handles LSPs and formatters
        use {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "jayp0521/mason-null-ls.nvim",
        }
        -- Improved code action menu
        -- > shows diffs and other stuff
        use "weilbith/nvim-code-action-menu"
        -- Shows LSP-Status live (useful for rust)
        use "j-hui/fidget.nvim"
        -- Better rename window
        use {
            'filipdutescu/renamer.nvim',
            branch = 'master',
            requires = { { 'nvim-lua/plenary.nvim' } }
        }

        -- Telescope --
        -- > Search engine and menus
        use {
            "nvim-telescope/telescope.nvim",
            requires = { { "nvim-lua/plenary.nvim" } },
        }
        -- Allows use of hop commands in telescope
        use "nvim-telescope/telescope-hop.nvim"
        -- Allows searching bookmarks
        use "tom-anders/telescope-vim-bookmarks.nvim"
        -- Allows vim ui selection via telescope
        use { 'nvim-telescope/telescope-ui-select.nvim' }
        -- Allows search using fzf
        use { 'nvim-telescope/telescope-fzf-native.nvim',
            run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

        -- Yank ring like plugin allows for pasting previous yank
        use "gbprod/yanky.nvim"

        -- Rust-Tools --
        -- > Needed for extra features of rust-analyzer
        use "simrat39/rust-tools.nvim"

        -- Hop --
        use {
            "phaazon/hop.nvim",
            branch = "v2",
        }

        -- NvimTree --
        -- > File manager
        use {
            "kyazdani42/nvim-tree.lua",
            requires = {
                "kyazdani42/nvim-web-devicons",
            },
        }

        -- Autopairs --
        use "windwp/nvim-autopairs"

        -- TreeSitter --
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
        }
        use "nvim-treesitter/playground"

        --
        use "ziontee113/syntax-tree-surfer"

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
                "jayp0521/mason-nvim-dap.nvim",
            },
        }

        -- Toggleterm --
        use "akinsho/toggleterm.nvim"

        -- vim-surround --
        use "tpope/vim-surround"

        -- Vim-Bookmarks --
        use "MattesGroeger/vim-bookmarks"

        -- Better Escape --
        use { 'jdhao/better-escape.vim', event = 'InsertEnter' }

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

        -- Notify --
        use "rcarriga/nvim-notify"

        -- Sniprun --
        use { 'michaelb/sniprun', run = 'bash ./install.sh' }

        -- Easy Align --
        use "junegunn/vim-easy-align"

        -- Leap --
        use "ggandor/leap.nvim"
        use "ggandor/flit.nvim"
        use "ggandor/leap-spooky.nvim"

        -- Firenvim --
        use {
            'glacambre/firenvim',
            run = function() vim.fn['firenvim#install'](0) end
        }

        -- Detect indents heuristically
        use 'tpope/vim-sleuth'

        -- Hydra for navigation
        use 'anuvyklack/hydra.nvim'

        -- For drawing diagrams
        use "jbyuki/venn.nvim"

        -- Local Nvim Config
        use {
            "klen/nvim-config-local",
            config = function()
                require('config-local').setup {}
            end
        }

        -- Fold Preview
        use {
            "anuvyklack/fold-preview.nvim",
            requires = 'anuvyklack/keymap-amend.nvim',
        }

        -- Comment.nvim
        use "numToStr/Comment.nvim"

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if PACKER_BOOTSTRAP then
            require("packer").sync()
        end
    end)
