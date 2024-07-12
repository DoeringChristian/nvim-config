return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            -- NOTE: If you are having trouble with this installation,
            --       refer to the README for telescope-fzf-native for more instructions.
            build = "make",
            cond = function()
                return vim.fn.executable "make" == 1
            end,
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require "telescope.builtin".oldfiles()
            end,
            desc = "Old Files",
        },
        {
            "<leader>ff",
            function()
                require "telescope.builtin".find_files()
            end,
            desc = "[F]ind [F]iles",
        },
        {
            "<leader>fg",
            function()
                require "telescope.builtin".live_grep()
            end,
            desc = "[F]ind using [G]rep",
        },
        {
            "<leader>fd",
            function()
                require "telescope.builtin".diagnostics()
            end,
            desc = "[F]ind [D]iagnostics",
        },
        {
            "<leader>fn",
            function()
                require "telescope.builtin".resume { initial_mode = "normal" }
            end,
            desc = "[F]ind [N]ext",
        },
        -- {
        --     "<leader><Tab>",
        --     function()
        --         return require 'telescope.builtin'.grep_string {
        --             path_display = { "smart" },
        --             shorten_path = true,
        --             word_match = "-w",
        --             only_sort_text = true,
        --             search = "",
        --         }
        --     end,
        --     desc = "Fuzzy Find"
        -- }
    },
    config = function()
        local actions = require "telescope.actions"
        require "telescope".setup {
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<c-f>"] = actions.to_fuzzy_refine,
                    },
                    n = {
                        ["q"] = "close",
                    }

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
                    initial_mode = 'normal',
                },
                lsp_definitions = {
                    initial_mode = 'normal',
                },
                lsp_implementations = {
                    initial_mode = 'normal',
                },
                lsp_document_symbols = {
                    --initial_mode = "normal",
                },
                lsp_incoming_calls = {
                    initial_mode = 'normal',
                },
                lsp_outgoing_calls = {
                    initial_mode = 'normal',
                },
                diagnostics = {
                    initial_mode = 'normal',
                },
                lsp_type_definitions = {
                    initial_mode = 'normal',
                },
                topts = {
                    initial_mode = 'normal',
                },
                colorscheme = {
                    initial_mode = 'normal',
                    enable_preview = true,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            },
        }
        require "telescope".load_extension "fzf"
    end
}
