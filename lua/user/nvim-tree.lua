local nvim_tree_status_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_status_ok then
    return
end

nvim_tree.setup {
    view = {
        mappings = {
            list = {
                { key = "l", action = "edit" },
                { key = "v", action = "vsplit" },
                { key = "s", action = "split" },
                { key = "t", action = "tabnew" },
                { key = "h", action = "close_node" },
                { key = "<BS>", action = "dir_up" },
                { key = "<CR>", action = "cd" },
            },
        },
    },
}

-- Autoclose
--[[
vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
            print("quit")
            vim.cmd "quit"
        end
    end
})
]] --
