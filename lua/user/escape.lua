vim.g.better_escape_shortcut = { "jk", "jK", "JK", "Jk" }
vim.g.better_escape_intervall = 1000

local ok, escape = pcall(require, "better_escape")
if not ok then
    return
end

escape.setup {
    mapping = { "jk", "JK", "Jk" },
    timeout = vim.o.timeoutlen,
    keys = "<esc>",
}
