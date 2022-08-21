local ok, sniprun = pcall(require, "sniprun")
if not ok then
    return
end

sniprun.setup {
    repl_enable = { 'Rust_original', 'C_original', 'Python3_original' }
}
