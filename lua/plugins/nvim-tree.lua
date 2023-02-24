vim.api.nvim_create_autocmd("WinClosed", {
    callback = function()
        local winnr = tonumber(vim.fn.expand("<amatch>"))
        vim.schedule_wrap(tab_win_closed(winnr))
    end,
    nested = true
})

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
            }
            -- diagnostic = {
            --     enable = true,
            --     show_on_dirs = true,
            -- },
        }
    end
}
