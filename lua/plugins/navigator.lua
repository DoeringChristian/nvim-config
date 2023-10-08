return {
    "numToStr/Navigator.nvim",
    enabled = true,
    config = function()
        vim.keymap.set({ 'n', 't' }, '<C-h>', '<CMD>NavigatorLeft<CR>')
        vim.keymap.set({ 'n', 't' }, '<C-l>', '<CMD>NavigatorRight<CR>')
        vim.keymap.set({ 'n', 't' }, '<C-k>', '<CMD>NavigatorUp<CR>')
        vim.keymap.set({ 'n', 't' }, '<C-j>', '<CMD>NavigatorDown<CR>')


        local ok, wezterm = pcall(function()
            return require('Navigator.mux.wezterm'):new()
        end)
        require "Navigator".setup {
            mux = ok and wezterm or 'auto'
        }
    end
}
