local ok, indent_blankline = pcall(require, "indent_blankline")
if not ok then
    return
end

indent_blankline.setup {
    show_current_contenxt = true,
    show_current_contenxt_start = true,
    char_highlight_list = {
        "IndentBlanklineIndent"
    }
}
