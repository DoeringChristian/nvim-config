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

return M
