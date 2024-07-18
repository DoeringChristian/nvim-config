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
  if client.server_capabilities.inlayHintProvider then
    -- There are multiple ways to enable inlay hits
    pcall(vim.lsp.inlay_hint, bufnr, true)
    pcall(vim.lsp.inlay_hint.enable, bufnr, true)
    pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
  end

  if client.server_capabilities.codeLensProvider then
    -- refresh codelens on TextChanged and InsertLeave as well
    vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach', 'BufEnter' }, {
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh({ bufnr = bufnr })
      end
    })
    vim.api.nvim_exec_autocmds("User", { pattern = "LspAttach" })
  end

  require "plugins.lsp.keymaps" (client, bufnr)
  lsp_highlight_document(client)

  --- Auto format using lsp-format if enabled
  local ok, lsp_format = pcall(require, "lsp-format")
  if ok then
    lsp_format.on_attach(client)
  end

  vim.notify("LSP Client: " .. client.name)
end
