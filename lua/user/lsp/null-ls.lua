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
    }
}

local M = {}

M.builtins = {
    yapf = {
        null_ls.builtins.formatting.yapf
    },
    autopep8 = {
        null_ls.builtins.formatting.autopep8
    },
    black = {
        null_ls.builtins.formatting.black
    }
}

return M
