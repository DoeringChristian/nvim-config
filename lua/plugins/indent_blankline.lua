return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        show_current_contenxt = true,
        show_current_contenxt_start = true,
        char_highlight_list = {
            "IndentBlanklineIndent"
        }
    }
}