local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
    return
end

toggleterm.setup {
    open_mapping = [[<C-t>]],
    terminal_mappings = true,
    direction = "float",
    float_opts = {
        border = "curved",
    },
}

local ok, terminal = pcall(require, 'toggleterm.terminal')
if not ok then
    return
end

local Terminal = terminal.Terminal


----------------------------------
-- Set Custom terminals.
----------------------------------
-- Prefix is <leader>t



local gitui = Terminal:new({ 
    cmd = "gitui",
    hidden = false,
})
function _gitui_toggle()
    gitui:toggle()
end

local bottom = Terminal:new({
    cmd = "btm",
    hidden = false,
})
function _bottom_toggle()
    bottom:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>ToggleTerm<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _gitui_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tb", "<cmd>lua _bottom_toggle()<CR>", {noremap = true, silent = true})

