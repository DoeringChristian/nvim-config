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

M.format = function(bufnr)
    pcall(vim.lsp.buf.format, { async = true })
    vim.bo[bufnr].modifiable = false -- Disable modifiable so we cannot have desyncs
    vim.b[bufnr].write_after_format = true
end

return M
