return {
  'aznhe21/actions-preview.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'MunifTanjim/nui.nvim',
  },
  keys = {
    {
      '<leader>a',
      function()
        require('actions-preview').code_actions()
      end,
      mode = { 'v', 'n' },
      desc = 'Code [A]ction',
    },
  },
  config = function()
    require('actions-preview').setup {
      telescope = require('telescope.themes').get_dropdown {

        initial_mode = 'normal',
      },
    }
  end,
}
