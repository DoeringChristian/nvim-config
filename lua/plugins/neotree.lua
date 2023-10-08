local icons = require "config.icons"
return {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true,
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<C-f>", "<CMD>Neotree toggle<CR>", desc = "Open [F]ile Manager" },
    },
    opts = {
        close_if_last_window = true,
        sort_case_insensitive = true,
        default_component_configs = {
            git_status = {
                symbols = icons.git,
            },
        },
        window = {
            position = "left",
            width = 40,
            mapping_options = {
                noremap = true,
                nowait = true,
            },
            mappings = {
                ["l"] = "open",
                ["s"] = "open_split",
                ["v"] = "open_vsplit",
                ["t"] = "open_tabnew",
                ["w"] = "open_with_window_picker",
            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                ["<C-j>"] = "move_cursor_down",
                ["<C-k>"] = "move_cursor_up",
            },
        },
    },
}
