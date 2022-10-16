local ok, mason = pcall(require, "mason")
if not ok then
    return
end

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
    return
end

local ok, mason_null_ls = pcall(require, "mason-null-ls")
if not ok then
    return
end

local function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

mason.setup {}
mason_lspconfig.setup {}
mason_null_ls.setup {}

-- LSP Setup Handlers:
local function lsp_default_handler(server_name)
    --print(server_name)
    local lspconfig = require("lspconfig")
    local config = {
        capabilities = require("user.lsp.handlers").capabilities,
        on_attach = require("user.lsp.handlers").on_attach,
    }

    local ok, settings_config = pcall(require, "user.lsp.settings." .. server_name)
    if ok then
        config = vim.tbl_deep_extend("force", config, settings_config)
    end

    lspconfig[server_name].setup(config)

end

mason_lspconfig.setup_handlers {
    lsp_default_handler,
    ["rust_analyzer"] = function()
    end
}

-- NULL-LS Setup Handlers
local function null_ls_default_handler(source_name)
    local ok, null_ls = pcall(require, "null-ls")
    if not ok then
        vim.notify("Error missing null-ls!")
        return
    end
    vim.notify("Null-ls server " .. source_name .. " registered.")

    null_ls.register(null_ls.builtins.formatting[source_name])
end

mason_null_ls.setup_handlers {
    null_ls_default_handler
}
