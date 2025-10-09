return {
  settings = {},
  capabilities = {
    didChangeWatchedFiles = {
      dynamicRegistration = true,
    },
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false,
        },
      },
    },
  },
}
