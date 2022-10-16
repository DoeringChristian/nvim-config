local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

null_ls.setup {
    on_attach = require("user.lsp.handlers").on_attach,
    log_level = "error",
}
