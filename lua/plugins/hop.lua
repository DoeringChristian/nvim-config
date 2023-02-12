return {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
        local hop = require "hop"
        -- Hop highlight
        vim.cmd [[hi! link HopNextKey DiagnosticError]]
        vim.cmd [[hi! link HopNextKey1 DiagnosticError]]
        vim.cmd [[hi! link HopNextKey2 DiagnosticWarn]]
        --vim.cmd [[hi! link HopNextKey lualine_a_normal]]
        --vim.cmd [[hi! link HopNextKey1 lualine_a_normal]]
        --vim.cmd [[hi! link HopNextKey2 String]]

        hop.setup {
            keys = "wertzuiopghyxcvbnmalskdjf",
            extend_visual = true,
        }
    end
}
