local util = require 'util'

return {
  'SmiteshP/nvim-navic',
  lazy = true,
  init = function()
    vim.g.navic_silence = true

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local buffer = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, buffer)
          vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
        end
      end,
    })
  end,
  opts = function()
    return {
      separator = ' ',
      -- highlight = true,
      depth_limit = 5,
      icons = require('config.icons').kinds,
    }
  end,
}
