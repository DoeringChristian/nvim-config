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
    labels = { "s", "f", "n", "u", "t", "r",
        "j", "k", "l", "o", "d", "w", "e", "h", "m", "v", "g",
        "c", ".", "z" },
    safe_labels = { "s", "f", "n", "u", "t", "r" },
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
vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = 'grey' })

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

local ok, spooky = pcall(require, "leap-spooky")
if not ok then
    return
end

spooky.setup {
    affixes = {
        -- These will generate mappings for all native text objects, like:
        -- (ir|ar|iR|aR|im|am|iM|aM){obj}.
        -- Special line objects will also be added, by repeating the affixes.
        -- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
        -- window.
        -- You can also use 'rest' & 'move' as mnemonics.
        remote   = { window = 'r', cross_window = 'R' },
        magnetic = { window = 'm', cross_window = 'M' },
    },
    -- If this option is set to true, the yanked text will automatically be pasted
    -- at the cursor position if the unnamed register is in use.
    paste_on_remote_yank = false,
}
