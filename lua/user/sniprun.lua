local ok, sniprun = pcall(require, "sniprun")
if not ok then
    return
end

sniprun.setup {
    repl_enable = { 'Python3_jupyter', 'Rust_original', 'C_original' },
    selected_interpreters = { 'Python3_original' },
}
