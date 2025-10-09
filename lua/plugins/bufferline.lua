return {
  'akinsho/bufferline.nvim',
  tag = 'v4.7.0',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  config = function()
    local mocha = require('catppuccin.palettes').get_palette 'mocha'
    require('bufferline').setup {
      options = {
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diag, context)
          local icons = require('config.icons').diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') .. (diag.warning and icons.Warn .. diag.warning or '')
          return vim.trim(ret)
        end,
        always_show_bufferline = true,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    }
  end,
}
