local ok, hop = pcall(require, "hop")
if not ok then
    return
end

-- Hop highlight
vim.cmd[[hi! link HopNextKey DiagnosticError]]
vim.cmd[[hi! link HopNextKey1 DiagnosticWarn]]
vim.cmd[[hi! link HopNextKey2 DiagnosticInfo]]

hop.setup {
    keys = "wertzuiopghyxcvbnmalskdjf",
    extend_visual = true,
}

