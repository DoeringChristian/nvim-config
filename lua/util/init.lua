local M = {}

M.on_attach = function(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

-- Declare functions for mapping
M.map = function(mode, keys, func, desc)
    if desc then
        desc = desc
    end
    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = desc })
end

M.nmap = function(keys, func, desc)
    M.map('n', keys, func, desc)
end

M.vmap = function(keys, func, desc)
    M.map('v', keys, func, desc)
end

M.xmap = function(keys, func, desc)
    M.map('x', keys, func, desc)
end

M.imap = function(keys, func, desc)
    M.map('i', keys, func, desc)
end

---@param server_name string
---@param settings_patcher fun(settings: table): table
function UpdateLspSettings(server_name, settings_patcher)
    local function patch_settings(client)
        settings_patcher(client.config.settings)
        client.notify("workspace/didChangeConfiguration", {
            settings = client.config.settings,
        })
    end

    local clients = vim.lsp.get_active_clients({ name = server_name })
    if #clients > 0 then
        patch_settings(clients[1])
        return
    end

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client.name == server_name then
                patch_settings(client)
                return true
            end
        end,
    })
end

return M
