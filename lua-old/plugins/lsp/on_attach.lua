-- local function enable_formatting(client, bufnr)
--     if not (type(bufnr) == "int") then
--         bufnr = vim.fn.bufnr('%')
--     end
--     local ag = vim.api.nvim_create_augroup("Format", {
--         clear = false
--     })
--
--     vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--         group = ag,
--         buffer = bufnr,
--         callback = function(ev)
--             require "plugins.lsp.formatting".callback(client, bufnr)
--         end
--     })
--     vim.notify("Formatting enabled, buffer: " .. bufnr .. " client: " .. client.name)
-- end

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec(
            [[
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]], false)
    end
end


return function(client, bufnr)
    require "plugins.lsp.keymaps" (client, bufnr)
    lsp_highlight_document(client)

    -- Auto format on safe (version dependent)
    -- if client.server_capabilities.documentFormattingProvider and AUTO_FORMAT_EXCLUDED[client.name] == nil and
    --     AUTO_FORMAT_EXCLUDED[vim.bo[bufnr].filetype] == nil then
    -- end
    require "lsp-format".on_attach(client)
    vim.notify("LSP Client: " .. client.name)
end
