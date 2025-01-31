local M = {}

--- Generates a config table from a server name
---@param Name of the server for which the config shall be generated
---@return returns the config table containing capabilities, on_attach, settings
M.config = function(server_name)
    local capabilities = require "cmp_nvim_lsp".default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }
    local config = {
        capabilities = capabilities,
        on_attach = require("plugins.lsp.on_attach"),
    }

    -- Extend default capabilites
    local ok, default_config = pcall(require, "config.lsp.settings.default")
    if ok then
        config = vim.tbl_deep_extend("force", config, default_config)
    end

    -- Load settings from usr/lsp/settings/$server_name
    local ok, server_config = pcall(require, "config.lsp.settings." .. server_name)

    -- Deep extend settings with custom lsp server settings
    if ok then
        config = vim.tbl_deep_extend("force", config, server_config)
    end

    return config
end

M.setup = function(server_name)
    local lspconfig = require "lspconfig"
    lspconfig[server_name].setup(M.config(server_name))
end

M.extend = function(config)
    local default = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = require("plugins.lsp.on_attach"),
    }

    config = vim.tbl_deep_extend("force", default, config)

    return config
end

return M
