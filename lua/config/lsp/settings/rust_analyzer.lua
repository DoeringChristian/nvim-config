return {
  settings = {
    ['rust-analyzer'] = {
      inlayHints = { locationLinks = false },
      -- assist = {
      --     importGranularity = "module",
      --     importPrefix = "self",
      -- },
      -- cargo = {
      --     loadOutDirsFromCheck = true,
      --     sysrootQueryMetadata = true,
      -- },
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
      completion = {
        postfix = {
          enable = false,
        },
        snippets = {
          custom = {},
        },
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
