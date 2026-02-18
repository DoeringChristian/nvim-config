return {
  {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup {
        default_mapping = false,
        mappings = {
          i = {
            j = {
              -- These can all also be functions
              k = '<Esc>',
            },
          },
          c = {
            j = {
              k = '<C-c>',
            },
          },
          t = {
            j = {
              k = '<C-\\><C-n>',
            },
          },
          v = {
            j = {
              k = '<Esc>',
            },
          },
          s = {
            j = {
              k = '<Esc>',
            },
          },
        },
      }
    end,
  },
}
