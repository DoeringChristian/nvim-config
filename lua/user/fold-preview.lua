local ok, fold_preview = pcall(require, "fold-preview")
if not ok then
    return
end

fold_preview.setup {
    auto = 100,
    border = "rounded",
}
