return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-hop.nvim",
        "tom-anders/telescope-vim-bookmarks.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "gbprod/yanky.nvim",
    },
    config = function()
        local telescope = require "telescope"
        local plenary = require "plenary"

        local R = function(name)
            local RELOAD = require("plenary.reload").reload_module
            RELOAD(name)
            return require(name)
        end

        --telescope.load_extension('media_files')
        -- telescope.load_extension("file_browser")
        --telescope.load_extension("neoclip")
        --telescope.load_extension("aerial")

        local actions = require "telescope.actions"

        telescope.setup {
            defaults = {

                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "smart" },

                mappings = {
                    i = {
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,
                        ["<C-h>"] = R("telescope").extensions.hop.hop,

                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,

                        ["<C-c>"] = actions.close,

                        ["<Down>"] = actions.move_selection_next,
                        ["<Up>"] = actions.move_selection_previous,

                        ["<CR>"] = actions.select_default,
                        ["<C-x>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-t>"] = actions.select_tab,

                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,

                        ["<PageUp>"] = actions.results_scrolling_up,
                        ["<PageDown>"] = actions.results_scrolling_down,

                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<C-l>"] = actions.complete_tag,
                        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
                    },

                    n = {
                        ["q"] = actions.close,
                        ["<esc>"] = actions.close,
                        --["jk"] = actions.close,
                        ["<CR>"] = actions.select_default,
                        ["l"] = actions.select_default,
                        ["h"] = actions.close,
                        ["<C-x>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-t>"] = actions.select_tab,

                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                        ["j"] = actions.move_selection_next,
                        ["k"] = actions.move_selection_previous,
                        ["H"] = actions.move_to_top,
                        ["M"] = actions.move_to_middle,
                        ["L"] = actions.move_to_bottom,

                        ["<Down>"] = actions.move_selection_next,
                        ["<Up>"] = actions.move_selection_previous,
                        ["gg"] = actions.move_to_top,
                        ["G"] = actions.move_to_bottom,

                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,

                        ["<PageUp>"] = actions.results_scrolling_up,
                        ["<PageDown>"] = actions.results_scrolling_down,

                        ["s"] = R("telescope").extensions.hop.hop,
                        ["S"] = R("telescope").extensions.hop.hop,

                        ["?"] = actions.which_key,
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
            },
            extensions = {
                -- Your extension configuration goes here:
                -- extension_name = {
                --   extension_config_key = value,
                -- }
                -- please take a look at the readme of the extension you want to configure
                hop = {
                    keys = { "w", "e", "r", "t",
                        "z", "u", "i", "o",
                        "p", "g", "h", "y",
                        "x", "c", "v", "b",
                        "n", "m", "a", "l",
                        "s", "k", "d", "j", "f", },
                    sign_hl = { "WarningMsg", "Title" },
                },
                ['ui-select'] = {
                    initial_mode = "normal"
                },
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },

            },
        }
        telescope.load_extension("yank_history")
        telescope.load_extension("hop")
        telescope.load_extension("vim_bookmarks")
        --telescope.load_extension("fzf")
        --telescope.load_extension("ui-select")
    end
}