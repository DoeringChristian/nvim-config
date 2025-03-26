return {
    "gbprod/yanky.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    keys = {
        { "p",     "<Plug>(YankyPutAfter)",      mode = { "n" },      desc = "[P]aste After" },
        { "p",     "<Plug>(YankyPutBefore)",     mode = { "x" },      desc = "[P]aste After (without copying replaced text)" },
        { "P",     "<Plug>(YankyPutBefore)",     mode = { "n", "x" }, desc = "[P]aste Before" },
        { "gp",    "<Plug>(YankyGPutAfter)",     mode = { "n", "x" }, desc = "[G]oto end [P]aste After" },
        { "gP",    "<Plug>(YankyGPutBefore)",    mode = { "n", "x" }, desc = "[G]oto end [P]aste Before" },
        { "<c-n>", "<Plug>(YankyCycleBackward)", mode = "n",          desc = "Next Paste Element" },
        { "<c-p>", "<Plug>(YankyCycleForward)",  mode = "n",          desc = "Previous Paste Element" },
        {
            "<leader>p",
            function()
                require "telescope".extensions.yank_history.yank_history {
                    initial_mode = "normal",
                }
            end,
            mode = "n",
            desc = "[P]aste Telescope"
        },
    },
    config = function()
        vim.g.clipboard = {
            name = "xsel_override",
            copy = {
                ["+"] = "xsel --input --clipboard",
                ["*"] = "xsel --input --primary",
            },
            paste = {
                ["+"] = "xsel --output --clipboard",
                ["*"] = "xsel --output --primary",
            },
            cache_enabled = 1,
        }
        local yanky = require "yanky"

        local mapping = require "yanky.telescope.mapping"
        local actions = require "telescope.actions"

        yanky.setup({
            ring = {
                history_length = 10,
                storage = "shada",
                sync_with_numbered_registers = true,
                update_register_on_cycle = true,
                ignore_registers = { "_" },
            },
            system_clipboard = {
                sync_with_ring = true,
            },
            preserver_cursor_position = {
                enabled = false,
            },
            picker = {
                select = {
                    action = nil,
                },
                telescope = {
                    use_default_mappings = false,
                    mappings = {
                        i = {
                            ["<c-p>"] = mapping.put("p"),
                            ["<c-P>"] = mapping.put("P"),
                            ["<c-x>"] = mapping.delete(),
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                        },
                        n = {
                            p = mapping.put("p"), -- put after cursor
                            P = mapping.put("P"),
                            d = mapping.delete(),
                        },
                    },
                },
            },
        })
    end,
}
