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
            },
        },
    },
}
