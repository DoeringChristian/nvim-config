local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

null_ls.setup {
    on_attach = require("user.lsp.handlers").on_attach,
    log_level = "error",
    sources = {
        --null_ls.builtins.formatting.yapf,
        --null_ls.builtins.formatting.autopep8,
        --null_ls.builtins.code_actions.refactoring
        null_ls.builtins.formatting.black,
        null_ls.builtins.code_actions.gitsigns
    }
}

local M = {}

M.builtins = {
    cspell = {
        null_ls.builtins.diagnostics.cspell,
        null_ls.builtins.code_actions.cspell
    },
    refactoring = {
        null_ls.builtins.code_actions.refactoring
    },
    yapf = {
        null_ls.builtins.formatting.yapf
    },
    autopep8 = {
        null_ls.builtins.formatting.autopep8
    },
    black = {
        null_ls.builtins.formatting.black
    },
    cbfmt = {
        null_ls.builtins.formatting.cbfmt
    }
}

return M
