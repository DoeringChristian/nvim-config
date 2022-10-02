local ok, escape = pcall(require, "better_escape")
if not ok then
    return
end

escape.setup {
    mapping = { "jk", "kj", "jj" },
    timeout = vim.o.timeoutlen,
}
