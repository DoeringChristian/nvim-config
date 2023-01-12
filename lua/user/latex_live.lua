local ts_utils = require 'nvim-treesitter.ts_utils'
local parsers = require "nvim-treesitter.parsers"

-- Get node at cursor in insert mode
local get_node_at_cursor = function()
    local winnr = 0
    local cursor = vim.api.nvim_win_get_cursor(winnr)
    local cursor_range = { cursor[1] - 1, cursor[2] - 1 }

    local buf = vim.api.nvim_win_get_buf(winnr)
    local root_lang_tree = parsers.get_parser(buf)
    if not root_lang_tree then
        return
    end

    local root
    root = ts_utils.get_root_for_position(cursor_range[1], cursor_range[2], root_lang_tree)

    if not root then
        return
    end

    return root:named_descendant_for_range(cursor_range[1], cursor_range[2], cursor_range[1], cursor_range[2])
end

local function replace_match(live)
    local bufnr = vim.api.nvim_win_get_buf(0)

    local current
    if live then
        current = get_node_at_cursor()
    else
        current = ts_utils.get_node_at_cursor()
    end

    if current == nil then
        return
    end
    if current:type() ~= "word" then
        return
    end
    if current:parent():type() ~= "text" then
        return
    end
    if current:parent():parent():type() ~= "curly_group_text" then
        return
    end
    if current:parent():parent():parent():parent():type() ~= "generic_environment" then
        return
    end

    local begin_or_end = current:parent():parent():parent()
    local env = begin_or_end:parent()

    local match
    if begin_or_end:type() == "begin" then
        match = env:named_child(1)
    elseif begin_or_end:type() == "end" then
        match = env:named_child(0)
    end
    print(match:type())

    local text = current:parent()
    local str = vim.treesitter.get_node_text(text, bufnr)

    if live then
        local c = vim.v.char
        str = str .. c
    end

    local match_text = match:named_child(0):named_child(0)
    local start_row, start_col, end_row, end_col = match_text:range()

    --vim.api.nvim_buf_set_lines()

    local line = vim.api.nvim_buf_get_lines(0, start_row, start_row + 1, false)
    line = line[1]
    local line = line:sub(0, start_col) .. str .. line:sub(end_col + 1)
    vim.api.nvim_buf_set_lines(0, start_row, start_row + 1, false, { line })

end

local au_grp = vim.api.nvim_create_augroup("LatexLiveEnd", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*.tex",
    callback = function()
        replace_match(false)
    end,
    group = au_grp
})
