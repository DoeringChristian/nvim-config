return{
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    keys = {
        {"<leader>?", function() require "telescope.builtin".oldfiles() end, desc = "Old Files"},
        {"<leader>ff", function() require "telescope.builtin".find_files() end , desc = "[F]ind [F]iles"},
        {"<leader>fg", function() require "telescope.builtin".grep_live() end, desc = "[F]ind using [G]rep"},
        {"<leader>fd", function() require "telescope.builtin".diagnostics() end, desc = "[F]ind [D]iagnostics"},
    },
    opts = {
        defaults = {
            mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
            },
        },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
                lsp_references = {
                    initial_mode = "normal",
                },
                lsp_definitions = {
                    initial_mode = "normal",
                },
                lsp_implementations = {
                    initial_mode = "normal",
                },
                lsp_document_symbols = {
                    --initial_mode = "normal",
                },
                lsp_incoming_calls = {
                    initial_mode = "normal",
                },
                lsp_outgoing_calls = {
                    initial_mode = "normal",
                },
                diagnostics = {
                    initial_mode = "normal",
                },
                lsp_type_definitions = {
                    initial_mode = "normal",
                },
                topts = {
                    initial_mode = "normal",
                },
                colorscheme = {
                    initial_mode = "normal",
                    enable_preview = true,
                },
            }
    }
  }