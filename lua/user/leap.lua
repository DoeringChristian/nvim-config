local ok, leap = pcall(require, "leap")
if not ok then
    return
end

require('leap').set_default_keymaps()
leap.setup {
    max_phase_one_targets = nil,
    highlight_unlabeled_phase_one_targets = false,
    max_highlighted_traversal_targets = 10,
    case_sensitive = false,
    equivalence_classes = { ' \t\r\n', },
    substitute_chars = {},
    labels = { "s", "f", "n",
        "j", "k", "l", "o", "d", "w", "e", "h", "m", "v", "g",
        "u", "t",
        "c", ".", "z" },
    safe_labels = { "s", "f", "n",
        "u", "t", "q", "r" },
    --"F", "L", "N", "H", "G", "M", "U", "T", "Z" },
    special_keys = {
        repeat_search = '<enter>',
        next_phase_one_target = '<enter>',
        next_target = { '<enter>', ';' },
        prev_target = { '<tab>', ',' },
        next_group = '<space>',
        prev_group = '<tab>',
        multi_accept = '<enter>',
        multi_revert = '<backspace>',
    },

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

local ok, flit = pcall(require, "flit")
if not ok then
    return
end

flit.setup {
    keys = { f = 'f', F = 'F', t = 't', T = 'T' },
    -- A string like "nv", "nvo", "o", etc.
    labeled_modes = "v",
    multiline = true,
    -- Like `leap`s similar argument (call-specific overrides).
    -- E.g.: opts = { equivalence_classes = {} }
    opts = {}
}
