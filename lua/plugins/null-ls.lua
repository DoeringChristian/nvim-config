return {
    "jose-elias-alvarez/null-ls.nvim", -- null-ls handles formatters etc.
    config = function()
        local null_ls = require "null-ls"
        null_ls.setup {
            on_attach = require("user.lsp.handlers").on_attach,
            log_level = "error",
            sources = {
                --null_ls.builtins.formatting.yapf,
                --null_ls.builtins.formatting.autopep8,
                --null_ls.builtins.code_actions.refactoring
                null_ls.builtins.formatting.black,
                --null_ls.builtins.code_actions.gitsigns
            }
        }
    end
}
