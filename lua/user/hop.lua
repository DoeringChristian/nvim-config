local ok, hop = pcall(require, "hop")
if not ok then
    return
end

-- Hop highlight
vim.cmd [[hi! link HopNextKey DiagnosticError]]
vim.cmd [[hi! link HopNextKey1 DiagnosticError]]
vim.cmd [[hi! link HopNextKey2 DiagnosticWarn]]

hop.setup {
    keys = "wertzuiopghyxcvbnmalskdjf",
    extend_visual = true,
}
