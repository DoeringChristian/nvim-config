return {
  -- NOTE: we are using noice for signature help, since this plugin seems to
  -- be broken on nvim 0.11
  'ray-x/lsp_signature.nvim',
  enabled = true,
  event = 'VeryLazy',
  opts = {
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = 'none',
    },
  },
  config = function(_, opts)
    require('lsp_signature').on_attach(opts)
  end,
}
