-- Temporary fix to refresh the buffer inlay hints after loading
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == 'texlab' then
      vim.defer_fn(function()
        vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
      end, 500)
    end
  end,
})

return {
  settings = {
    texlab = {
      build = {
        executable = 'tectonic',
        args = {
          '-X',
          'compile',
          '%f',
          '--synctex',
          '--keep-logs',
          '--keep-intermediates',
        },
        onSave = true,
      },
      bibtexFormatter = 'texlab',
      chktex = {
        onEdit = false,
        onOpenAndSave = false,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,

      -- Zathura config
      forwardSearch = {
        executable = 'zathura',
        args = { '--synctex-forward', '%l:1:%f', '%p' },
      },

      --latexFormatter = "latexindent",
      latexFormatter = 'latexindent',
      latexindent = {
        modifyLineBreaks = false,
      },

      inlayHints = {
        labelDefinitions = true,
        labelReferences = true,
        maxLength = 10,
      },
    },
  },
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
  },
}
