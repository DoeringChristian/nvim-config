local ok, escape = pcall(require, "better_escape")
if not ok then
    return
end

escape.setup {
    mapping = { "jk", "JK", "Jk", "kj", "KJ", "Kj" },
    --timeout = vim.o.timeoutlen,
    timeout = 100,
    keys = "<esc>",
}
