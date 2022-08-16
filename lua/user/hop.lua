local ok, hop = pcall(require, "hop")
if not ok then
    return
end

-- Hop highlight
--vim.cmd [[hi! link HopNextKey DiagnosticError]]
--vim.cmd [[hi! link HopNextKey1 DiagnosticError]]
--vim.cmd [[hi! link HopNextKey2 DiagnosticWarn]]
vim.cmd [[hi! link HopNextKey Error]]
vim.cmd [[hi! link HopNextKey1 Error]]
vim.cmd [[hi! link HopNextKey2 String]]

hop.setup {
    keys = "wertzuiopghyxcvbnmalskdjf",
    extend_visual = true,
}
