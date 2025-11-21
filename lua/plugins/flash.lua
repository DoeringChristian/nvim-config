return {
  {
    'folke/flash.nvim',
    enabled = false,
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      search = {
        wrap = false,
      },
      label = {
        uppercase = false,
        reuse = 'all',
      },
      jump = {
        autojump = true,
      },
    },
    keys = {

      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump { search = { forward = true, wrap = false, multi_window = false } }
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump { search = { forward = false, wrap = false, multi_window = false } }
        end,
        desc = 'Flash',
      },
      {
        'o',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
}
