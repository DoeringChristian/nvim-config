return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<C-f>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file manager" },
    },
    config = function()
        local nvim_tree = require "nvim-tree"

        nvim_tree.setup {
            view = {
                mappings = {
                    list = {
                        { key = "l",    action = "edit" },
                        { key = "v",    action = "vsplit" },
                        { key = "s",    action = "split" },
                        { key = "t",    action = "tabnew" },
                        { key = "h",    action = "close_node" },
                        { key = "<BS>", action = "dir_up" },
                        { key = "<CR>", action = "cd" },
                    },
                },
            },
            diagnostics = {
                enable = true,
                show_on_dirs = false,
                show_on_open_dirs = true,
                severity = {
                    min = vim.diagnostic.severity.WARN,
                    max = vim.diagnostic.severity.ERROR,
                },
            },
            filters = {
                dotfiles = true,
            }
        }
    end
}
