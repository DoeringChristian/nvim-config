return {
  settings = {

    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      telemetry = {
        enable = false,
      },
      workspace = {
        library = {
          [vim.fn.expand '$VIMRUNTIME/lua'] = true,
          [vim.fn.stdpath 'config' .. '/lua'] = true,
        },
      },
    },
  },
}
