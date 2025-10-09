return {
  settings = {
    texlab = {
      auxDirectory = 'build',
      bibtexFormatter = 'texlab',
      build = {
        executable = 'tectonic',
        args = {
          '-X',
          'compile',
          '%f',
          '--synctex',
          '--keep-logs',
          '--keep-intermediates',
          '--outdir',
          'build',
        },
        onSave = true,
      },
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
        labelDefinitions = false,
        labelReference = false,
      },
    },
  },
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
