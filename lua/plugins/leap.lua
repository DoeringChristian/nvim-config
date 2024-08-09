return {
    "ggandor/leap.nvim",
    enabled = true,
    lazy = false,
    dependencies = {
        -- "ggandor/flit.nvim",
        -- "ggandor/leap-spooky.nvim",
    },
    config = function()
        local leap = require "leap"

        leap.set_default_keymaps()
        vim.keymap.set({ 'n', 'x', 'o' }, "ga", function()
            require "leap.treesitter".select()
        end)
        leap.setup({
            max_phase_one_targets = nil,
            highlight_unlabeled_phase_one_targets = false,
            max_highlighted_traversal_targets = 10,
            case_sensitive = false,
            equivalence_classes = { " \t\r\n" },
            substitute_chars = {},
            relative_directions = true,
            labels = {
                "s",
                "f",
                "n",
                "u",
                "t",
                "r",
                "j",
                "k",
                "l",
                "o",
                "d",
                "w",
                "e",
                "h",
                "m",
                "v",
                "g",
                "c",
                ".",
                "z",
            },
            safe_labels = { "s", "f", "n", "u", "t", "r" },
            --"F", "L", "N", "H", "G", "M", "U", "T", "Z" },
            special_keys = {
                repeat_search = "<enter>",
                next_phase_one_target = "<enter>",
                next_target = { "<enter>", ";" },
                prev_target = { "<tab>", "," },
                next_group = "<space>",
                prev_group = "<tab>",
                multi_accept = "<enter>",
                multi_revert = "<backspace>",
            },
        })

        vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    end,
}
