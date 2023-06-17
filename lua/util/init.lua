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

M.format_async = function(bufnr)
    vim.bo[bufnr].modifiable = false -- Disable modifiable so we cannot have desyncs
    vim.b[bufnr].write_after_format = true
    pcall(vim.lsp.buf.format, { async = true })
end

M.apply_formatting = function(bufnr, result, client_id)
    local util = require "vim.lsp.util"
    vim.bo[bufnr].modifiable = true
    if not result then
        return
    end
    local client = vim.lsp.get_client_by_id(client_id)
    -- vim.notify("formatting with " .. client.name)
    util.apply_text_edits(result, bufnr, client.offset_encoding)
    if vim.b[bufnr].write_after_format then
        vim.cmd("let buf = bufnr('%') | exec '" .. bufnr .. "bufdo :noa w' | exec 'b' buf") -- Save the correct buffer
    end
    vim.b[bufnr].write_after_format = nil
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


return M
