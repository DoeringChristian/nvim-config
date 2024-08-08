return {
    "gbprod/yanky.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    keys = {
        { "p",     "<Plug>(YankyPutAfter)",      mode = { "n", "x" }, desc = "[P]aste After" },
        { "P",     "<Plug>(YankyPutBefore)",     mode = { "n", "x" }, desc = "[P]aste Before" },
        { "gp",    "<Plug>(YankyGPutAfter)",     mode = { "n", "x" }, desc = "[G]oto end [P]aste After" },
        { "gP",    "<Plug>(YankyGPutBefore)",    mode = { "n", "x" }, desc = "[G]oto end [P]aste Before" },
        { "<c-n>", "<Plug>(YankyCycleBackward)", mode = "n",          desc = "Next Paste Element" },
        { "<c-p>", "<Plug>(YankyCycleForward)",  mode = "n",          desc = "Previous Paste Element" },
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
        local yanky = require("yanky")

        local mapping = require("yanky.telescope.mapping")

        yanky.setup({
            ring = {
                history_length = 10,
                storage = "shada",
                sync_with_numbered_registers = true,
                update_register_on_cycle = true,
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
                    mappings = {
                        default = mapping.put("p"),
                        i = {
                            ["<c-p>"] = mapping.put("p"),
                            ["<c-P>"] = mapping.put("P"),
                            ["<c-x>"] = mapping.delete(),
                        },
                        n = {
                            p = mapping.put("p"),
                            P = mapping.put("P"),
                            d = mapping.delete(),
                        },
                    },
                },
            },
        })

        local picker = require("yanky.picker")
        picker.actions.put("p")
        picker.actions.put("P")
        picker.actions.put("gp")
        picker.actions.put("gP")
        picker.actions.delete()
    end,
}
