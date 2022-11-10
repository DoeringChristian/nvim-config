local ok, escape = pcall(require, "better_escape")
if not ok then
    return
end

escape.setup {
    mapping = { "jk", "JK", "Jk" },
    timeout = vim.o.timeoutlen,
    keys = "<esc>",
}
