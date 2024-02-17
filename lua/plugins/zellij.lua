return {
    "Lilja/zellij.nvim",
    enabled = false,
    config = function()
        vim.keymap.set({ 'n', 't' }, '<C-h>', '<CMD>ZellijNavigateLeft<CR>')
        vim.keymap.set({ 'n', 't' }, '<C-l>', '<CMD>ZellijNavigateRight<CR>')
        vim.keymap.set({ 'n', 't' }, '<C-k>', '<CMD>ZellijNavigateUp<CR>')
        vim.keymap.set({ 'n', 't' }, '<C-j>', '<CMD>ZellijNavigateDown<CR>')
    end
}
