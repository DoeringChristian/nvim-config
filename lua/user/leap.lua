local ok, leap = pcall(require, "leap")
if not ok then
    return
end

require('leap').set_default_keymaps()
leap.setup {
    case_insensitive = true,
    labels = { "s", "f", "n",
        "j", "k", "l", "o", "d", "w", "e", "h", "m", "v", "g",
        "u", "t",
        "c", ".", "z",
        "F", "L", "N", "H", "G", "M", "U", "T", "Z" },
    safe_labels = { "s", "f", "n",
        "u", "t",
        "F", "L", "N", "H", "G", "M", "U", "T", "Z" },
}

function LEAP_ALL_WINDOWS()
    require('leap').leap { target_windows = vim.tbl_filter(
        function(win) return vim.api.nvim_win_get_config(win).focusable end,
        vim.api.nvim_tabpage_list_wins(0)
    ) }
end

function LEAP_BIDIRECTIONAL()
    require('leap').leap { target_windows = { vim.fn.win_getid() } }
end
