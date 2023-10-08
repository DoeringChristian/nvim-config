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
        default_component_configs = {
            git_status = {
                symbols = require "config.icons".git,
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
        },
    },
}
