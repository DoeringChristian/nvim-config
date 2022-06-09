local ok, aerial = pcall(require, 'aerial')
if not ok then
    return
end


aerial.setup{
    open_automatic = true,
    placement_editor_edge = true,
    close_behavior = "global",
    show_guides = true,
    highlight_on_hover = true,
    ignore = {
        filetypes = {
            "lua",
        }
    }
}

