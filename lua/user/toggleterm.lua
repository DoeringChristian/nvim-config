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

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-t>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

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
function _GITUI_TOGGLE()
    gitui:toggle()
end

local bottom = Terminal:new({
    cmd = "btm",
    hidden = false,
})
function _BOTTOM_TOGGLE()
    bottom:toggle()
end

local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = false,
})
function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

local dust = Terminal:new({
    cmd = "dust",
    hidden = false,
})
function _DUST_TOGGLE()
    dust:toggle()
end

local htop = Terminal:new({
    cmd = "htop",
    hidden = false,
})
function _HTOP_TOGGLE()
    htop:toggle()
end
