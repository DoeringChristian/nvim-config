return {
    "kyazdani42/nvim-tree.lua",
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
        }

        -- Autoclose
        vim.api.nvim_create_autocmd("BufEnter", {
            nested = true,
            callback = function()
                if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
                    print("quit")
                    vim.cmd "quit"
                end
            end
        })
    end
}
