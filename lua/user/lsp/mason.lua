local ok, mason = pcall(require, "mason")
if not ok then
    return
end

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
    return
end

mason.setup {}
mason_lspconfig.setup {}

local function default_handler(server_name)
    --print(server_name)
    local lspconfig = require("lspconfig")
    local setup_config = {
        capabilities = require("user.lsp.handlers").capabilities,
        on_attach = require("user.lsp.handlers").on_attach,
    }

    local ok, config = pcall(require, "user.lsp.settings." .. server_name .. ".lua")
    if ok then
        setup_config = vim.tbl_deep_extend("force", setup_config, config)
    end

    lspconfig[server_name].setup(setup_config)

end

mason_lspconfig.setup_handlers {
    default_handler,
}
